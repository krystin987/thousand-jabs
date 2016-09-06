-- Adapted from https://bitbucket.org/doub/dump/src
local MAJOR, MINOR = "LibPrtrDump-1.0", 1

local math = math
local table = table
local string = string

local indenter = '  '
local groupsize = 10000

local dumptablecontent

local tkeys = {
	boolean = true,
	number = true,
	string = true,
}
local tvalues = {
	boolean = true,
	number = true,
	string = true,
	table = true,
	['function'] = true,
}

local function dumptable(tbl, write, level, refs)
	-- prefix and suffix
	local mt = getmetatable(tbl)
	local prefix = mt and mt.__dump_prefix
	local suffix = mt and mt.__dump_suffix
	if type(prefix)=='function' then
		prefix = prefix(tbl)
	end
	prefix = prefix or ""
	if type(suffix)=='function' then
		suffix = suffix(tbl)
	end
	suffix = suffix or ""
	
	-- count keys
	local nkeys = 0
	for k,v in pairs(tbl) do
		nkeys = nkeys + 1
		local tk,tv = type(k),type(v)
		if not tkeys[tk] then
			return nil,"unsupported key type '"..tk.."'"
		end
		if not (tvalues[tv] or getmetatable(v) and getmetatable(v).__dump) then
			return nil,"unsupported value type '"..tv.."'"
		end
	end
	
	-- if too many keys, use multiple closures
	if nkeys > groupsize then
		local success,err
		success,err = write(((prefix..[[
(function()
	local t = { function() return {
]]):gsub("\n", "\n"..(indenter):rep(level))))
		if not success then return nil,err end
		success,err = dumptablecontent(tbl, write, level+2, groupsize, (indenter):rep(level+1)..'} end, function() return {\n', refs)
		if not success then return nil,err end
		success,err = write((([[
	} end }
	local result = {}
	for _,f in ipairs(t) do
		for k,v in pairs(f()) do
			result[k] = v
		end
	end
	return result
end)()]]..suffix):gsub("\n", "\n"..(indenter):rep(level))))
		if not success then return nil,err end
		return true
	elseif nkeys==0 then
		local success,err = write(prefix.."{ }"..suffix)
		if not success then return nil,err end
		return true
	else
		local success,err
		success,err = write(prefix.."{\n")
		if not success then return nil,err end
		success,err = dumptablecontent(tbl, write, level+1, nil, nil, refs)
		if not success then return nil,err end
		success,err = write((indenter):rep(level).."}"..suffix)
		if not success then return nil,err end
		return true
	end
end

local function dumpvalue(v, write, level, refs, iskey)
	local mt = getmetatable(v)
	local dump = mt and mt.__dump
	if type(dump)=='function' then
		dump = dump(v)
	end
	if dump~=nil then
		return write(dump)
	end
	local t = type(v)
	if t=='string' then
		if not iskey and v:match('\n.*\n') and not v:match('[\000-\008\011-\031\127]') then
			local eq
			for i=0,math.huge do
				eq = string.rep('=', i)
				if not v:match('%]'..eq..'%]') then
					break
				end
			end
			return write('['..eq..'[\n'..v..']'..eq..']')
		else
			return write('"'..v:gsub('[%z\1-\31\127"\\]', function(c)
				if c=='\\' then
					return '\\\\'
				elseif c=='"' then
					return '\\"'
				elseif c=='\t' then
					return '\\t'
				elseif c=='\n' then
					return '\\n'
				elseif c=='\r' then
					return '\\r'
				else
					return string.format('\\%03d', string.byte(c))
				end
			end)..'"')
		end
	elseif t=='number' then
		if v~=v then -- nan
			return write('0/0')
		elseif v==1/0 then -- +inf
			return write('1/0')
		elseif v==-1/0 then -- -inf
			return write('-1/0')
		elseif v==math.floor(v) then
			return write(tostring(v))
		else
			local s = string.format('%.18f', v):gsub('(%..-)0*$', '%1')
			if tonumber(s)~=v then
				s = string.format("%a", v) -- Lua 5.3.1
			end
			if tonumber(s)~=v then
				s = string.format("%.13a", v) -- Lua 5.3.0
			end
			return write(s)
		end
	elseif t=='boolean' then
		if v then
			return write('true')
		else
			return write('false')
		end
	elseif t=='nil' then
		return write('nil')
	elseif t=='table' then
		return dumptable(v, write, level, refs)
	elseif t=='function' then
		return write('['..tostring(v)..']')
	else
		return nil,"unsupported value type '"..t.."'"
	end
end

local lua_keywords = {
	['and'] = true,
	['break'] = true,
	['do'] = true,
	['else'] = true,
	['elseif'] = true,
	['end'] = true,
	['false'] = true,
	['for'] = true,
	['function'] = true,
	['if'] = true,
	['in'] = true,
	['local'] = true,
	['nil'] = true,
	['not'] = true,
	['or'] = true,
	['repeat'] = true,
	['return'] = true,
	['then'] = true,
	['true'] = true,
	['until'] = true,
	['while'] = true,
}

local function dumppair(k, v, write, level, refs)
	if refs and refs[v] then
		v = refs[v].link
	end
	local success,err
	success,err = write((indenter):rep(level))
	if not success then return nil,err end
	local assignment = " = "
	local tk = type(k)
	if tk=='string' and k:match("^[_a-zA-Z][_a-zA-Z0-9]*$") and not lua_keywords[k] then
		success,err = write(k)
		if not success then return nil,err end
	elseif tk=='string' or tk=='number' or tk=='boolean' then
		success,err = write('[')
		if not success then return nil,err end
		success,err = dumpvalue(k, write, level, refs, true)
		if not success then return nil,err end
		success,err = write(']')
		if not success then return nil,err end
	elseif tk=='nil' then
		-- we are in the array part
		assignment = ""
	else
		error("unsupported key type '"..type(k).."'")
	end
	success,err = write(assignment)
	if not success then return nil,err end
	success,err = dumpvalue(v, write, level, refs)
	if not success then return nil,err end
	success,err = write(",\n")
	if not success then return nil,err end
	return true
end

local function keycomp(a, b)
	local ta,tb = type(a),type(b)
	if ta==tb then
		return a < b
	else
		return ta=='string'
	end
end

local tsort = table.sort
local function dumptablesection(tbl, write, level, keys, state, refs)
	-- sort keys
	local skeys = {}
	for k in pairs(keys) do skeys[#skeys+1] = k end
	tsort(skeys, keycomp)
	-- dump pairs
	for _,k in pairs(skeys) do
		local v = tbl[k]
		if state then
			state.i = state.i + 1
			if state.i % state.size == 0 then
				local success,err = write(state.sep)
				if not success then return nil,err end
			end
		end
		local success,err = dumppair(k, v, write, level, refs)
		if not success then return nil,err end
	end
	return true
end

local function dumptableimplicitsection(tbl, write, level, state, refs)
	for k,v in ipairs(tbl) do
		if state then
			state.i = state.i + 1
			if state.i % state.size == 0 then
				local success,err = write(state.sep)
				if not success then return nil,err end
			end
		end
		local success,err
		if state then
			success,err = dumppair(k, v, write, level, refs)
		else
			success,err = dumppair(nil, v, write, level, refs)
		end
		if not success then return nil,err end
	end
	return true
end

function dumptablecontent(tbl, write, level, groupsize, groupsep, refs)
	-- order of groups:
	-- - explicit keys
	--   - keys with simple values
	--   - keys with structure values (table with only explicit keys)
	--   - keys with mixed values (table with both exiplicit and implicit keys)
	--   - keys with array values (table with only implicit keys)
	-- - set part (explicit key with boolean value)
	-- - implicit keys
	-- order within a group:
	-- - string keys in lexicographic order
	-- - numbers in increasing order
	-- :TODO: handle tables as keys
	-- :TODO: handle sets
	
	-- extract implicit keys
	local implicit = {}
	for k,v in ipairs(tbl) do
		implicit[k] = true
	end
	-- categorize explicit keys
	local set = {}
	local simples = {}
	local structures = {}
	local mixeds = {}
	local arrays = {}
	for k,v in pairs(tbl) do
		if not implicit[k] then
			if type(v)=='table' then
				if v[1]==nil then
					structures[k] = true
				else
					local implicit = {}
					for k in ipairs(v) do
						implicit[k] = true
					end
					local mixed = false
					for k in pairs(v) do
						if not implicit[k] then
							mixed = true
							break
						end
					end
					if mixed then
						mixeds[k] = true
					else
						arrays[k] = true
					end
				end
			else
				simples[k] = true
			end
		end
	end
	
	local success,err,state
	if groupsize and groupsep then
		state = {
			i = 0,
			size = groupsize,
			sep = groupsep,
		}
	end
	success,err = dumptablesection(tbl, write, level, simples, state, refs)
	if not success then return nil,err end
	success,err = dumptablesection(tbl, write, level, structures, state, refs)
	if not success then return nil,err end
	success,err = dumptablesection(tbl, write, level, mixeds, state, refs)
	if not success then return nil,err end
	success,err = dumptablesection(tbl, write, level, arrays, state, refs)
	if not success then return nil,err end
	success,err = dumptableimplicitsection(tbl, write, level, state, refs)
	if not success then return nil,err end
	return true
end

local function ref_helper(processed, pending, cycles, refs, value, parent, key, path)
	if type(value)=='table' then
		local vrefs = refs[value]
		if not vrefs then
			vrefs = {
				value = value,
			}
			refs[value] = vrefs
		end
		table.insert(vrefs, {parent=parent, key=key})
		if pending[value] then
			cycles[value] = {pending[value], {key, path}}
			return
		end
		if not processed[value] then
			local path = {key, path}
			processed[value] = true
			pending[value] = path
			for k,v in pairs(value) do
				ref_helper(processed, pending, cycles, refs, k, value, nil, path)
				ref_helper(processed, pending, cycles, refs, v, value, k, path)
			end
			pending[value] = nil
			-- only assign an index once the children have one
			refs.last = refs.last + 1
			vrefs.index = refs.last
		end
	end
end

local prefixes = {
	['table'] = 't',
	['function'] = 'f',
	['thread'] = 'c',
	['userdata'] = 'u',
}

local function check_refs(root)
	local processed = {}
	local pending = {}
	local cycles = {}
	local refs = {last=0}
	ref_helper(processed, pending, cycles, refs, root, nil, nil)
	refs.last = nil
	for value,vrefs in pairs(refs) do
		if #vrefs==1 then
			refs[value] = nil
		end
	end
	return cycles,refs
end

local function cycle_paths(cycles)
	local paths = {}
	for _,path_pair in pairs(cycles) do
		local top,bottom = path_pair[1],path_pair[2]
		local root = {}
		local cycle = {}
		local it = bottom
		while it~=top do
			table.insert(cycle, 1, it[1])
			it = it[2]
		end
		while it and it[1] do
			table.insert(root, 1, it[1])
			it = it[2]
		end
		table.insert(paths, {root, cycle})
	end
	return paths
end

local function dump_tostring(value, ignore_refs)
	local cycles,refs = check_refs(value)
	if next(cycles) then
		return nil,"cycles in value",cycle_paths(cycles)
	end
	if next(refs) and not ignore_refs then
		return nil,"mutable values (tables) with multiple references"
	end
	local t = {}
	local success,err = dumpvalue(value, function(str) table.insert(t, str); return true end, 0, refs)
	if not success then return nil,err end
	return table.concat(t)
end

local IsLoadedByWoW = GetSpellInfo and true or false
if IsLoadedByWoW then
    local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
    function lib:Dump(value)
        return dump_tostring(value)
    end
else
    return dump_tostring
end