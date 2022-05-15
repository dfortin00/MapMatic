local lib = (...):gsub("plugins.Box2D$", '')
local cwd = (...):gsub("%.Box2D$", '') .. '.'

local utils      = require(lib .. "utils")
local Class      = require(lib .. "class")
local maputils   = require(lib .. "mapfactory.maputils")
local PluginBase = require(cwd .. "PluginBase")

local Box2DPlugin = Class {
    __name        = "Box2DPlugin",
    __includes    = PluginBase,
    __version     = "0.9.0",
    __license     = "MIT/X11",
    __description = "Box2D plugin for MapMatic Map Library"
}

--===============
-- GLOBAL STRINGS
--===============

-- To interact with the Box2DPlugin, create properties on layers, tiles, or objects with
-- the following names and types. These names can be altered if you wish to use different
-- names for your Tiled map properties (the proprety types must remain the same, however).

-- Note: The box2d_collidable boolean property is mandatory, and must appear and be set to
-- true for the other properties to have an effect.

BOX2D_COLLIDABLE  = "box2d_collidable"   -- boolean
BOX2D_DYNAMIC     = "box2d_dynamic"      -- boolean
BOX2D_STATIC      = "box2d_static"       -- boolean
BOX2D_KINEMATIC   = "box2d_kinematic"    -- boolean
BOX2D_FRICTION    = "box2d_friction"     -- float
BOX2D_RESTITUTION = "box2d_restitution"  -- float
BOX2D_SENSOR      = "box2d_sensor"       -- boolean
BOX2D_CATEGORIES  = "box2d_categories"   -- int
BOX2D_MASK        = "box2d_mask"         -- int
BOX2D_GROUP       = "box2d_group"        -- int

--===========================
--==[[ PRIVATE METHODS ]]==--
--===========================

--- Increments the collision id counter and returns the current collision id.
---@param plugin table The current plugin
---@return number id
local function _increment_collision_id(plugin)
    local id = plugin.nextcollisionid or 1
    plugin.nextcollisionid = id + 1
    return id
end

--- Destroys a single collision object from the table.
---@param plugin table The current plugin
---@param collision table The collision object to destroy
---@param index number The index the collision object appears in the plugin.collisions table
local function _destroy_collision(plugin, collision, index)
    if not (collision.body == plugin.collisions.body) then
        -- Destroying Box2D bodies also destroys their fixtures.
        collision.body:destroy()
    else
        -- Didn't destroy the body, so need to destroy the fixture.
        collision.fixture:destroy()
    end
    collision.shape:release()

    -- Ensure garbage collection.
    collision.object  = nil
    collision.body    = nil
    collision.fixture = nil
    collision.shape   = nil

    table.remove(plugin.collisions, index)
end

--- Sets up the Box2D fixtures and bodies and adds the collision objects to the main table.
---@param plugin table The current plugin
---@param shape string The shape of the object
---@param vertices table Table containing set of vertices for the shape
---@param userdata table The user data that will be passed into the fixture.
---@param object table The object that owns the collision data
local function _add_object_to_world(plugin, shape, vertices, userdata, object)
    local shape2d

    if shape == "polyline" then
        if #vertices == 4 then
            shape2d = love.physics.newEdgeShape(unpack(vertices))
        else
            shape2d = love.physics.newChainShape(false, unpack(vertices))
        end
    else
        shape2d = love.physics.newPolygonShape(unpack(vertices))
    end

    local map   = plugin:getMap()
    local body  = plugin.collisions.body
    local world = plugin:getWorld()
    local props = object.properties

    -- Dynamic are game objects/players/etc...
    if props:get(BOX2D_DYNAMIC) == true then
        body = love.physics.newBody(world, map:getOffsetX(), map:getOffsetY(), "dynamic")

     -- Kinematic means the object is static in the game world, but it still affects other bodies.
    elseif props:get(BOX2D_KINEMATIC) == true then
        body = love.physics.newBody(world, map:getOffsetX(), map:getOffsetY(), "kinematic")

    -- Static means it shouldn't move, like walls or the ground.
    elseif props:get(BOX2D_STATIC) == true then
        body = love.physics.newBody(world, map:getOffsetX(), map:getOffsetY(), "static")
    end

    local fixture = love.physics.newFixture(body, shape2d)

    -- Set some custom properties from the userdata (or use the default provided by the plugin).
    fixture:setFriction(props:get(BOX2D_FRICTION) or 0.2)
    fixture:setRestitution(props:get(BOX2D_RESTITUTION) or 0.0)
    fixture:setSensor(props:get(BOX2D_SENSOR) or false)
    fixture:setFilterData(
        props:get(BOX2D_CATEGORIES) or 1,
        props:get(BOX2D_MASK)       or 0xFFFF,
        props:get(BOX2D_GROUP)      or 0
    )

    local collision = {
        id         = userdata.id,
        body       = body,
        shape      = shape2d,
        fixture    = fixture,
        object     = userdata.object,
        properties = userdata.properties,
    }

    fixture:setUserData(collision)
    table.insert(plugin.collisions, collision)
end

--- Calculates the position of the separate parts of an ellipse polygon.
---@param plugin table The current plugin
---@param o table Temporary table of calculated object values
---@param object table The map object
---@param userdata table The user data that will be passed into the fixture
---@param tile? table The tile that owns the map object
local function _calculate_ellipse_position(plugin, o, object, userdata, tile)
    if not o.polygon then
        o.polygon = maputils.convertEllipseToPolygon(o.x, o.y, o.width, o.height)
    end
    local vertices  = maputils.flattenVertexTable(o.polygon)
    local triangles = love.math.triangulate(vertices)

    for _, triangle in ipairs(triangles) do
        _add_object_to_world(plugin, "ellipse", triangle, userdata, tile or object)
    end
end

--- Calculates the position of the separate parts of a polygon.
---@param plugin table The current plugin
---@param o table Temporary table of calculated object values
---@param object table The map object
---@param userdata table The user data that will be passed into the fixture
---@param tile? table The tile that owns the map object
local function _calculate_polygon_position(plugin, o, object, userdata, tile)
    if tile then
        local cos = math.cos(o.rotation)
        local sin = math.sin(o.rotation)

        for _, vertex in ipairs(o.polygon) do
            vertex.x = vertex.x + o.x
            vertex.y = vertex.y + o.y
            maputils.rotateVertex(plugin:getMap(), vertex, o.x, o.y, cos, sin)
        end
    end

    -- Note: Polygons must not intersect themselves, otherwise love.math.triangulate() will generate an error.
    local vertices = maputils.flattenVertexTable(o.polygon)
    local triangles = love.math.triangulate(vertices)

    for _, triangle in ipairs(triangles) do
        _add_object_to_world(plugin, "polygon", triangle, userdata, tile or object)
    end
end

--- Calculates the position of the object that will eventually be used to create the Box2D components.
---@param plugin table The current plugin
---@param object table The map object
---@param tile? table The tile that owns the map object
local function _calculate_object_position(plugin, object, tile)
    if object.shape == "point" then return end

    local map      = plugin:getMap()
    local o = {
        shape    = object.shape,
        x        = object.x + map:getOffsetX(),
        y        = object.y + map:getOffsetY(),
        width    = object.width,
        height   = object.height,
        rotation = object.rotation or 0,
        polygon  = object.getVertices and object:getVertices() or (object.polygon or {})
    }
    local userdata = {
        id         = _increment_collision_id(plugin),
        object     = o,
        properties = utils.table.copy(object.properties),
    }

    local shape = object.shape
    if shape == "rectangle" or shape == "tileobject" then
        local map = plugin:getMap()
        local cos = math.cos(o.rotation)
        local sin = math.sin(o.rotation)
        local oy  = 0

        if shape == "tileobject" then
            local tileobj = object:getTile()

            o.y = o.y + tileobj:getOffsetY()
            oy  = o.height

            if tileobj:hasObjects() then
                for _, obj in ipairs(tileobj:getObjects()) do
                    _calculate_object_position(plugin, obj, object)
                end
                return
            else
                local t = map:getTile(object:getGid())
                o.width  = t:getWidth()
                o.height = t:getHeight()
            end
        end

        local x, y, w, h = o.x, o.y, o.width, o.height
        o.polygon = {
            { x = x     , y = y     },
            { x = x + w , y = y     },
            { x = x + w , y = y + h },
            { x = x     , y = y + h },
        }

        for _, vertex in ipairs(o.polygon) do
            maputils.rotateVertex(map, vertex, x, y, cos, sin, oy)
        end

        local vertices = maputils.flattenVertexTable(o.polygon)
        _add_object_to_world(plugin, shape, vertices, userdata, tile or object)

    elseif shape == "ellipse" then
        _calculate_ellipse_position(plugin, o, object, userdata, tile)

    elseif shape == "polygon" then
        _calculate_polygon_position(plugin, o, object, userdata, tile)

    elseif shape == "polyline" then
        local vertices = maputils.flattenVertexTable(o.polygon)
        _add_object_to_world(plugin, "polyline", vertices, userdata, tile or object)
    end
end

--============
-- TILE LAYERS
--============

--- Searches for any objects associated with a tile instance and checks if any of them
--- have a collidable flag set to true.
---@param plugin table The current plugin
---@param instance table The tile instance that owns the objects
local function _collidable_instance_objects(plugin, instance)
    if instance:hasObjects() then
        local objects = instance:getObjects()
        for _, mapobj in ipairs(objects) do
            if mapobj:getProperty(BOX2D_COLLIDABLE) == true then
                local object = {
                    shape      = mapobj:getShape(),
                    x          = instance:getX() + mapobj:getX(),
                    y          = instance:getY() + mapobj:getY(),
                    width      = mapobj:getWidth(),
                    height     = mapobj:getHeight(),
                    rotation   = mapobj:getRotation(),
                    polygon    = mapobj:getVertices(),
                    properties = mapobj.properties,
                }

                _calculate_object_position(plugin, object)
            end
        end
    end
end

--- Check if the tile used by the instance has the collidable flag set to true.
---@param plugin table The current plugin
---@param instance table The tile instance that owns the tiles
local function _collidable_instance_tile(plugin, instance)
    local tile    = instance:getTile()
    local tileset = tile:getTileSet()
    if tile:getProperty(BOX2D_COLLIDABLE) == true then
        local object = {
            shape      = "rectangle",
            x          = instance:getX(),
            y          = instance:getY(),
            width      = tileset:getTileWidth(),
            height     = tileset:getTileHeight(),
            rotation   = 0,
            properties = tile.properties,
        }

        _calculate_object_position(plugin, object, tile)
    end
end

--- Checks the tile instances for a tile layer as well as whether the layer itself has
--- the colliable flag set to true.
---@param plugin table The current plugin
---@param layer table The tile layer to search
---@param instances table The tile instances belonging to the tile layer
local function _collidable_tile_layer(plugin, layer, instances)
    if not (layer:getProperty(BOX2D_COLLIDABLE) == true) then return end

    for _, instance in ipairs(instances) do
        local tile = instance:getTile()
        local tileset = instance:getTileSet()

        local object = {
            shape      = "rectangle",
            x          = instance:getX(),
            y          = instance:getY(),
            width      = tileset:getTileWidth(),
            height     = tileset:getTileHeight(),
            rotation   = 0,
            properties = layer.properties,
        }

        _calculate_object_position(plugin, object, tile)
    end
end

--- Scans through the list of tile layers and looks for any Box2D collidable properties.
---@param plugin table The Box2D plugin
---@param layers table Table containing the list of layers on the map
local function _check_tile_layers(plugin, layers)
    if not layers.tilelayers then return end
    for _, layer in ipairs(layers.tilelayers) do
        local instances = layer:getTileInstances()

        for _, instance in ipairs(instances) do
            _collidable_instance_objects(plugin, instance)
            _collidable_instance_tile(plugin, instance)
        end

        _collidable_tile_layer(plugin, layer, instances)
    end
end

--==============
-- OBJECT LAYERS
--==============

--- Checks tile objects for the collidable property, or if the tile object has any map objects
--- that have the collidable flag.
---@param plugin table The current plugin
---@param tileobject table The tile map object
local function _collidable_tile_objects(plugin, tileobject)
    local tile = tileobject:getTile()
    if tile:getProperty(BOX2D_COLLIDABLE) == true then
        _calculate_object_position(plugin, tileobject, tile)
    elseif tile:hasObjects() then
        for _, mapobj in ipairs(tile:getObjects()) do
            if mapobj:getProperty(BOX2D_COLLIDABLE) == true then
                local object = {
                    shape      = mapobj:getShape(),
                    x          = tileobject:getX() + mapobj:getX(),
                    y          = tileobject:getY() + mapobj:getY(),
                    width      = mapobj:getWidth(),
                    height     = mapobj:getHeight(),
                    rotation   = mapobj:getRotation(),
                    polygon    = mapobj:getVertices(),
                    properties = mapobj.properties,
                }

                _calculate_object_position(plugin, object, tile)
            end
        end
    end
end

--- Check individual objects from an object layer for the Box2D collidable property.
---@param plugin table The Box2D plugin
---@param objects table List of objects from an object layer
local function _collidable_objects(plugin, objects)
    for _, object in ipairs(objects) do
        if object:getProperty(BOX2D_COLLIDABLE) == true then
            _calculate_object_position(plugin, object)
        elseif object:getShape() == "tileobject" then
            _collidable_tile_objects(plugin, object)
        end
    end
end

--- Scans through the list of object layers and looks for objects that have the collidable property set to true.
---@param plugin table The Box2D plugin
---@param layers table Table containing the list of layers on the map
local function _check_object_layers(plugin, layers)
    if not layers.objectgroups then return end
    for _, layer in ipairs(layers.objectgroups) do
        local objects = layer:getObjects()

        if layer:getProperty(BOX2D_COLLIDABLE) == true then
            for _, object in ipairs(objects) do
                _calculate_object_position(plugin, object)
            end
        else
            _collidable_objects(plugin, objects)
        end
    end
end

--=============
-- IMAGE LAYERS
--=============

--- Scans through the list of image layers and looks to see if the collidable property has been set to true.
---@param plugin table The Box2D plugin
---@param layers table Table containing the list of layers on the map
local function _check_image_layers(plugin, layers)
    if not layers.imagelayers then return end
    for _, layer in ipairs(layers.imagelayers) do
        if layer:hasImage() and layer:getProperty(BOX2D_COLLIDABLE) == true then

            local object = {
                shape      = "rectangle",
                x          = layer:getOffsetX(),
                y          = layer:getOffsetY(),
                width      = layer:getWidth(),
                height     = layer:getHeight(),
                rotation   = 0,
                properties = layer.properties,
            }

            _calculate_object_position(plugin, object)
        end
    end
end

--=============

--- Scans through the map looking for any layers, tiles, or objects that contain Box2D properties.
---@param plugin table The current plugin
---@param map table The current map
---@param world userdata The LOVE2D World object
local function _setup_plugin(plugin, map, world)
    local body = love.physics.newBody(world, map:getOffsets())

    plugin.world      = world
    plugin.collisions = { body = body }

    -- Retrieve all layers grouped by layer types.
    local layers = map:getLayers(true)

    -- Scan through the map for any layers, tiles or objects for any Box2D plugin properties.
    _check_tile_layers(plugin, layers)
    _check_object_layers(plugin, layers)
    _check_image_layers(plugin, layers)
end

--=========================
--==[[ CLASS METHODS ]]==--
--=========================

--- Initializes the Box2D plugin. Note the World object passed in will still need to be
--- updated by the user in the love.update(dt) method.
---@param map table The map that owns the plugin instance
---@param world userdata The LOVE2D World object
function Box2DPlugin:init(map, world)
    assert(love.physics, "Box2D plugin requires the LOVE2D physics module enabled")
    assert(type(world) == "userdata" and world.type and world:type("World"), "Box2D : world parameter is not a valid LOVE2D World object type")
    PluginBase.init(self, map)
    _setup_plugin(self, map, world)
end

--- Retrieves the Box2D world object used to set up this plugin. Note: The plugin does not own
--- the World object being used, and you should take caution when modifying it.
---@return userdata world
function Box2DPlugin:getWorld()
    return self.world
end

--- Returns a table with all collision objects belonging to an object. Some objects such as ellipses
--- are broken down into separate polygons and will result in more than one collision object being created.
---@param id number The id of the collision in the table.
---@return table collision
function Box2DPlugin:getCollision(id)
    assert(type(id) == "number", "getCollision : id parameter must be a number type")
    if id < 1 or id > (self.nextcollisionid - 1) then return {} end

    local collisions = {}
    for _, collision in ipairs(self.collisions) do
        if collision.id == id then
            table.insert(collisions, collision)
        end
    end

    return collisions
end

--- Returns the full collision table.
---@return table collisions
function Box2DPlugin:getCollisions()
    return self.collisions
end

--- Destroys fixtures and shapes from the Box2D world for a specific collision object, and removes
--- the collision objects from the table.
---@param id number Id of the collision object to remove
function Box2DPlugin:destroyCollision(id)
    assert(type(id) == "number", "destroyCollision : id parameter must be a number type")
    if id < 1 or id > (self.nextcollisionid - 1) then return end

    for i = #self.collisions, 1, -1 do
        local collision = self.collisions[i]
        if collision.id == id then
            _destroy_collision(self, collision, i)
        end
    end
end

--- Destroys all collisions in the world belonging to the current map.
function Box2DPlugin:destroyCollisions()
    for i = #self.collisions, 1, -1 do
        _destroy_collision(self, self.collisions[i], i)
    end
end

--- Draws all of the Box2D shapes on the screen. Used mainly for debugging purposes.
---@param tx number Translation override in the x-direction
---@param ty number Translation override in the y-direction
---@param sx number Scalling override in the x-direction
---@param sy number Scalling override in the y-direction
function Box2DPlugin:render(tx, ty, sx, sy)
    love.graphics.push()

    if sx or (sx and sy) then
        love.graphics.scale(sx or 1, sy or sx or 1)
    end
    if tx and ty then
        love.graphics.translate(math.floor(tx), math.floor(ty))
    end

    for _, collision in ipairs(self:getCollisions()) do
        local points  = {collision:getWorldPoints()}
        local shape_t = collision:getShapeType()

        if shape_t == "edge" or shape_t == "chain" then
            love.graphics.line(points)
        elseif shape_t == "polygon" then
            love.graphics.polygon("line", points)
        else
            error("Box2D : plugin does not support rendering shape of type \"" .. shape_t .. "\"")
        end
    end

    love.graphics.pop()
end

return Box2DPlugin