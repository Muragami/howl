
-- ********************************************************************************
-- locals we need
local util = require 'howl/util.lua'
local tinsert = table.insert
local clone = util.clone
--local cloneInto = util.cloneInto

-- the root space the parser operates within
local root
-- the modules in this parser space
local mod
-- transliteration of Math/math.
local mathTable = {
    'abs', 'acos', 'asin', 'atan', 'atan2', 'ceil', 'cos', 'cosh', 'deg', 'exp',
    'floor', 'fmod', 'frexp', 'huge', 'idexp', 'log', 'log10', 'max', 'min', 'modf',
    'pi', 'pow', 'rad', 'random', 'randomseed', 'sin', 'sinh', 'sqrt', 'tan', 'tanh'
}
-- transliteration of String/string.
local stringTable = {
    'byte', 'char', 'find', 'format', 'gmatch', 'gsub', 'len', 'lower', 'match',
    'rep', 'reverse', 'sub', 'upper'
}

-- ********************************************************************************
-- base local functions

local function strToLineTable(str)
    local t = {}
    -- gmatch our lines
    for line in string.gmatch(str, "([^\n]+)") do
        -- trim starting and end whitespace
        local s = string.gsub(line, "^%s*(.-)%s*$", "%1")
        table.insert(t, s)
    end
    return t
end

return {
    install = function(self, aroot) -- install the parser into the root instance
        root = aroot
        mod = aroot.module
    end,
    new = function(self) -- return a new parser with it's own namespace for use
        return {
            root = root,
            mod = clone(mod)
        }
    end
}