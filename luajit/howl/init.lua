-- howl init.lua, just return the module here, functionality in other files
local howl =
{
    _NAME         = "howl",
	_VERSION      = "0.1.0",
	_DESCRIPTION  = 'A howl language to Luajit parser/transpiler',
	_URL          = 'http://github.com/Muragami/howl',
	_COPYRIGHT    = 'Copyright (c) 2026 muragami, JasonP, Jason A. Petrasko',
	_LICENSE_TYPE = 'MIT',
	_LICENSE      = [[
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]
}

-- the parser itself
howl.parser = require('howl/parser.lua')
-- link into the parser itself
howl.parser:install(howl)
-- install core module classes
howl.module = {
    Class = require('howl/_class.lua'),
    Fiber = require('howl/_fiber.lua'),
    Fn = require('howl/_fn.lua'),
    List = require('howl/_list.lua'),
    Map = require('howl/_map.lua'),
    Object = require('howl/_object.lua'),
    Range = require('howl/_range.lua'),
    Sequence = require('howl/_sequence.lua'),
}
-- install needed library routines
howl.lib = {
    string = require('howl/lib_string.lua'),
    number = require('howl/lib_number.lua'),
    buffer = require('string.buffer'),
    bit = require('bit')
}

if love then
-- if we are in love2d, bind the always enabled modules
howl.module.Data = love.data
howl.module.FileSystem = love.filesystem
-- add a function to bind love2d modules
howl.loveBind = function(self, name)
    local sname = string.lower(name)
    if love[sname] then
        self.module[name] = love[sname]
    else
        error("love2d does not contain module: " .. (name or 'nil'))
    end
end
end

return howl