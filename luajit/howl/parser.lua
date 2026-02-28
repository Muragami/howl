
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

-- ********************************************************************************
-- let's get to parsing! *rolls up sleeves*

--[[
    here we parse the howl source into luajit source.
    @param infoTable table If you pass a table to here, it'll get all kinds of data
        about the code, including a md5 hash of the trimmed source.
    @param getTable table If you pass a table here, it'll get the final generated
        source code as lines in that table.
]]
local function strParse(self, str, infoTable, genTable)
    local lines = strToLineTable(str)
    if infoTable and type(infoTable) == 'table' then
        -- we got an info table passed to set it up
        local md5 = self.root.md5.new()
        for _, ln in ipairs(lines) do
            md5:update(ln)
        end
        infoTable.src = {
            lineCount = #lines,
            textHash = md5:finish()
        }
    end
    -- we are a stateful parse, so keep track of the state using locals
    local mode = 'pre-class'
    local className = false
    local methodName = false
    local functionName = false
    local currentLine = 1
    for i, ln in ipairs(lines) do
        currentLine = i
        
    end
end

-- ********************************************************************************
-- put it all together and return it

return {
    install = function(self, aroot) -- install the parser into the root instance
        root = aroot
        mod = aroot.module
    end,
    new = function(self) -- return a new parser with it's own namespace for use
        return {
            root = root,
            mod = clone(mod),
            parse = strParse
        }
    end
}