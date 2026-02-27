local function Object_type0(self)
    return self._type
end

local function Object_is1(self, other)
    if self._type == other._type then
        return true
    else
        if self._super then
            return self._super:is(other)
        end
    end
    return false
end

local function Vector2_length1(self, other)
    return ((other.x - self.x) ^ 2 + (other.y - self.y) ^ 2) ^ 0.5
end

local function Vector2_add(self, other)
    self.x = self.x + other.x
    self.y = self.y + other.y
    return self
end

local MetaVector2 = {
    __add = Vector2_add
}

local function Vector2_new2(nx, ny)
    local ret = {
        _super = false,
        x = 0,
        y = 0,
        length = Vector2_length1
    }
    ret.x = nx or 0
    ret.y = ny or 0
    setmetatable(ret, MetaVector2)
    ret._type = 'Vector2'
    return ret
end

Vector2 = {
    _super = false,
    _type = 'Vector2',
    type = Object_type0,
    is = Object_is1,
    x = 0,
    y = 0,
    new = Vector2_new2,
    length = Vector2_length1
}

local function Point_new2(nx, ny)
    local ret = {
        _super = Vector2,
        x = 0,
        y = 0,
        length = Vector2_length1
    }
    ret.x = nx or 0
    ret.y = ny or 0
    setmetatable(ret, MetaVector2)
    ret._type = 'Point'
    return ret
end

Point = {
    _super = Vector2,
    _type = 'Point',
    type = Object_type0,
    is = Object_is1,
    x = 0,
    y = 0,
    new = Point_new2,
    length = Vector2_length1
}

--[[
class Vector2
    _x = 0
    _y = 0

    construct new(nx, ny)
        _x = nx
        _y = ny
    ;

    +(other)
        _x = _x + other.x
        _y = _y + other.y
    ;

    length(other) ((other.x - _x) ^ 2 + (other.y - _y) ^ 2) ^ 0.5
;

class Point is Vector2
    construct new(nx, ny)
        super.new(nx, ny)
    ;
;

class Distance is Vector2
    construct new(nx, ny)
        super.new(nx, ny)
    ;
;
]]
