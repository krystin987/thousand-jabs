#include "util.hpp"

std::string util::filename(const std::string& path)
{
    return path.substr(1 + path.rfind('/'));
}

std::string util::camel_to_underscores(const std::string& input)
{
    std::string ret;
    for(const auto& c : input)
    {
        if(std::isupper(c) && ret.size())
            ret += '_';
        ret += std::tolower(c);
    }
    return ret;
}

std::string util::make_slug(const std::string& name)
{
    std::string ret;
    for(const auto& c : name)
    {
        auto x = std::tolower(c);
        if(std::isalnum(x))
            ret += x;
        else if(std::isspace(x))
            ret += '_';
    }
    return ret;
}

int util::classID_from_classMask(int mask)
{
    int classID = 0;
    while(mask)
    {
        ++classID;
        mask >>= 1;
    }
    return classID;
}

int util::classMask_from_classID(int classID)
{
    return (1 << (classID - 1));
}
