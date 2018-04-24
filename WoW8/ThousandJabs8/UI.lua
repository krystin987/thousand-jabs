--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BfA only.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if select(4, GetBuildInfo()) < 80000 then
    return
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Module init.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local addonName, TJ, _ = ...
local LibStub, DBG, CT, RT, Config, UI, UnitCache, SpellBook = LibStub, TJ.DBG, CT, RT, TJ.Config, TJ.UI, TJ.UnitCache, TJ.SpellBook

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sandbox
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LibStub('LibTJSandbox-8.0'):Use(addonName)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function UI:PROFILE_ACTIVATED(classID, specID)
    TJ:DevPrint('PROFILE_ACTIVATED(UI): %d %d', classID, specID)
end

function UI:PROFILE_DEACTIVATED(classID, specID)
    TJ:DevPrint('PROFILE_DEACTIVATED(UI): %d %d', classID, specID)
end

UI:RegisterCallback('PROFILE_ACTIVATED')
UI:RegisterCallback('PROFILE_DEACTIVATED')
