--
-- classic
--
-- forked from rxi/classic
--
-- A tiny class module for Picotron and PICO-8.
--
-- Copyright (c) 2025, ahai64
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--

local Object = {}
Object.__index = Object

function Object:new(...)
end

function Object:extend()
    local claass = {}
    for k, v in pairs(self) do
        if k[1] == '_' and k[2] == '_' then
            claass[k] = v
        end
    end
    claass.__index = claass
    claass.super = self
    setmetatable(claass, self)
    return claass
end

function Object:implement(...)
    for _, claass in pairs({ ... }) do
        for k, v in pairs(claass) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

function Object:is(T)
    local mt = getmetatable(self)
    while mt do
        if mt == T then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end

function Object:__tostring()
    return "Object"
end

function Object:__call(...)
    local obj = setmetatable({}, self)
    obj:new(...)
    return obj
end

return Object
