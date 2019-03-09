local class = require("lib.30log")

local DEFAULTPARAM = function(value,def)
    if (value == nil) then return def end
    return value
end

-------------------------------------------------------
--__________EDITOR RESOURCES_________________________--
local EditorWorld = function(gx,gy,sleep)
    return {
        gravity = {gx,gy}, 
        sleep = sleep, 
        bodies = {}, 
        joints = {}
    }
end

local EditorBody = function(type,gravityScale,sleep)
    return {
        type = type, -- "static", "dynamic", "kinematic"
        gravityScale = gravityScale,
        sleep = sleep,
        fixtures = {},
        linearDamping = 0,
        linearVelocity = 0,
        fixedRotation = false,
        userData = nil
    }
end

local EditorFixture = function()
    return {
        density = 1,
        friction = 0,
        restitution = 0,
        sensor = false,
        userData = nil,
        shape = nil
    }
end

local EditorShape = function(type,data)
    return {type = type, data = data, userData = nil}
end

-------------------------------------------------------
--__________EDITOR RESOURCE MANAGER__________________--
local EditorResourceManager = class("EditorResourceManager")

function EditorResourceManager:init()
    self.PixelMeterScale = 64
    self.Worlds = {}
    self.Bodies = {}
    self.Fixtures = {}
    self.Shapes = {}
end

function EditorResourceManager:SetPixelMeterScale(pixels)
    self.PixelMeterScale = pixels
end

function EditorResourceManager:HasWorld(name)
    return self.Worlds[name] ~= nil
end

function EditorResourceManager:CreateWorld(name,gx,gy,sleep)
    -- Prevent duplicate names
    if (self:HasWorld(name)) then
        local i = 0
        while (self:HasWorld(name .. "_" .. tostring(i))) do
            i = i + 1
        end
        
        -- Apply new name to name
        name = name .. "_" .. tostring(i)
    end
    
    local world = EditorWorld(gx,gy,DEFAULTPARAM(sleep,true))
    self.Worlds[name] = world
end

function EditorResourceManager:DeleteWorld(name)
    self.Worlds[name] = nil
end

function EditorResourceManager:HasBody(name) 
    return self.Bodies[name] ~= nil
end

function EditorResourceManager:CreateBody(name,type,gravityScale,sleep)
    -- Prevent duplicate names
    if (self:HasBody(name)) then
        local i = 0
        while (self:HasBody(name .. "_" .. tostring(i))) do
            i = i + 1
        end
        
        -- Apply new name to name
        name = name .. "_" .. tostring(i)
    end

    local body = EditorBody(DEFAULTPARAM(type,"dynamic"),DEFAULTPARAM(gravityScale,1),DEFAULTPARAM(sleep,true))
    self.Bodies[name] = body
end

function EditorResourceManager:DeleteBody(name)
    self.Bodies[name] = nil
end

function EditorResourceManager:HasFixture(name)
    return self.Fixtures[name] ~= nil
end

function EditorResourceManager:CreateFixture(name)
    -- Prevent duplicate names
    if (self:HasFixture(name)) then
        local i = 0
        while (self:HasFixture(name .. "_" .. tostring(i))) do
            i = i + 1
        end
        
        -- Apply new name to name
        name = name .. "_" .. tostring(i)
    end
    
    local fixture = EditorFixture()
    self.Fixtures[name] = fixture
end

function EditorResourceManager:DeleteFixture(name)
    self.Fixtures[name] = nil
end

function EditorResourceManager:HasShape(name)
    return self.Shapes[name] ~= nil
end

function EditorResourceManager:CreateShape(name,type)
    -- Prevent duplicate names
    if (self:HasShape(name)) then
        local i = 0
        while (self:HasShape(name .. "_" .. tostring(i))) do
            i = i + 1
        end
        
        -- Apply new name to name
        name = name .. "_" .. tostring(i)
    end
    
    type = DEFAULTPARAM(type,"circle")
    local data = nil
    if (type == "circle") then
        data = { x = 0, y = 0, radius = 32 }
    else
        data = { points = {} }
    end

    local shape = EditorShape(type,data)
    self.Shapes[name] = shape
end

function EditorResourceManager:DeleteShape(name)
    self.Shapes[name] = nil
end




local Editor = class("Editor")

function Editor:init()
    self.resources = EditorResourceManager()
end

return Editor