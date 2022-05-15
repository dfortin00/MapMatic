
local mapdir = "assets/maps/plugins/box2d/"

-- Map variables
local tile_layer__tiles          = mapdir .. "tile_layer_5x5__tiles"
local tile_layer__layers         = mapdir .. "tile_layer_5x5__layers"
local tile_layer__tile_objects   = mapdir .. "tile_layer_5x5__tile_objects"

local object_layer__layers       = mapdir .. "object_layer_5x5__layers"
local object_layer__objects      = mapdir .. "object_layer_5x5__objects"
local object_layer__tile_objects = mapdir .. "object_layer_5x5__tile_objects"
local object_layer__map_objects  = mapdir .. "object_layer_5x5__tile_object__map_objects"

local image_layer__images        = mapdir .. "image_layer_5x5__images"
local image_layer__no_images     = mapdir .. "image_layer_5x5__no_images"

local bodies_map                 = mapdir .. "bodies_5x5"
local fixtures_map               = mapdir .. "fixtures_5x5"

-- Some helper functions to make test cases more readable.
local function _world(xg, yg)
    if TestBox2DPlugin.world then return TestBox2DPlugin.world end
    TestBox2DPlugin.world = love.physics.newWorld(xg or 0, yg or 0)
    return TestBox2DPlugin.world
end

local function _load_plugin(map, world, xg, yg)
    return map:loadPlugin("Box2D", world or _world(xg, yg))
end

TestBox2DPlugin = {}

    function TestBox2DPlugin:tearDown()
        MapFactory:clearCache()
        if self.world then
            self.world:destroy()
            self.world = nil
        end
    end

    ---------

    function TestBox2DPlugin:test_box2d_plugin__class_name()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertEquals(plugin:type(), "Box2DPlugin")
    end

    function TestBox2DPlugin:test_box2d_plugin__type_of()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertIsTrue(plugin:typeOf("PluginBase"))
    end

    --[[ Box2DPlugin:init ]]

    function TestBox2DPlugin:test_box2d_plugin_init__map()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertIsTrue(plugin.map == map)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__world()
        local map = MapFactory(tile_layer__layers)
        local world = love.physics.newWorld(0, 0)
        local plugin = _load_plugin(map, world)
        lu.assertIsTrue(plugin.world == world)
        world:destroy()
    end

    function TestBox2DPlugin:test_box2d_plugin_init__collisions()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertIsTable(plugin.collisions)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__default_body()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertNotIsNil(plugin.collisions.body)
        lu.assertEquals(plugin.collisions.body:type(), "Body")
    end

    --=======================
    --==[[ Tile Layers ]]==--
    --=======================

    -------------------------------
    -- Tile Layer Collision Objects
    -------------------------------

    -- Note: When a tile layer has box2d_collidable=true, all tile instances on the layer will be
    -- added as a collision object. Verify one collision object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__number_collision_objects()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 5)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instances__box2d_shape()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instances__fixture()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instances__body()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instances__properties()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        local props = plugin.collisions[2].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__shape()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__xy()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local instance = map:getLayer("tile_layer__collidable_true"):getTileInstance(1, 1)
        local object = plugin:getCollision(2)[1].object

        lu.assertEquals({object.x, object.y}, {instance.x, instance.y})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__width()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, tileset.tilewidth)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__height()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, tileset.tileheight)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__rotation()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layer__tile_instances__object__polygon()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(#object.polygon, 4)
    end

    ---------------------------------------------
    -- Tile Instance Map Object Collision Objects
    ---------------------------------------------

    -- Note: Tile instances use tiles which can have map objects with the box2d_collidable=true flag.
    -- Verify one collision object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instance_objects__number_collision_objects()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 1)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instance_objects__box2d_shape()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instance_objects__fixture()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instance_objects__body()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tile_instance_objects__properties()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        local props = plugin:getCollision(1)[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__shape()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)

        local mapobj = map:getLayer("tile_layer"):getTileInstance(1, 1):getTile():getObject(1)
        local collision = plugin:getCollision(1)[1]
        local shape = collision.object.shape

        lu.assertEquals(shape, mapobj:getShape())
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__xy()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)
        local instance = map:getLayer("tile_layer"):getTileInstance(1, 1)
        local collision = plugin:getCollision(1)[1]
        local object = collision.object
        lu.assertEquals({object.x, object.y}, {instance.x + 1, instance.y + 2})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__width()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)

        local mapobj = map:getLayer("tile_layer"):getTileInstance(1, 1):getTile():getObject(1)
        local collision = plugin:getCollision(1)[1]
        local object = collision.object

        lu.assertEquals(object.width, mapobj.width)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__height()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)

        local mapobj = map:getLayer("tile_layer"):getTileInstance(1, 1):getTile():getObject(1)
        local collision = plugin:getCollision(1)[1]
        local object = collision.object

        lu.assertEquals(object.height, mapobj.height)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__rotation()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)

        local mapobj = map:getLayer("tile_layer"):getTileInstance(1, 1):getTile():getObject(1)
        local collision = plugin:getCollision(1)[1]
        local object = collision.object

        lu.assertEquals(object.rotation, mapobj.rotation)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_objects__object__polygon()
        local map = MapFactory(tile_layer__tile_objects)
        local plugin = _load_plugin(map)

        local collision = plugin:getCollision(1)[1]
        local object = collision.object

        lu.assertEquals(#object.polygon, 4)
    end

    ---------------------------------------
    -- Tile Instance Tile Collision Objects
    ---------------------------------------

    -- Note: Tile instances can have global tiles with the box2d_collidable=true flag. Verify one
    -- collision object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tiles__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 2)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__box2d_shape()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__fixture()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__body()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__tile_layers__tiles__collision_properties()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local props = plugin.collisions[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__shape()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].object.shape
        lu.assertEquals(shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__xy()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)

        local instance = map:getLayer("tile_layer"):getTileInstance(1, 1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals({object.x, object.y}, {instance.x, instance.y})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__width()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, tileset.tilewidth)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__height()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, tileset.tileheight)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__rotation()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__shape__tile_instance_tiles__object__polygon()
        local map = MapFactory(tile_layer__tiles)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(#object.polygon, 4)
    end

    --=========================
    --==[[ Object Layers ]]==--
    --=========================

    ---------------------------------
    -- Object Layer Collision Objects
    ---------------------------------

    -- Note: Object layers can have the box2d_collidable=true flag which makes all objects added to the layer
    -- collidable. Use this scenario to test the collision objects for all types of objects.

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__layers__number_collisions()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 40)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__layers__fixture()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__layers__body()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__layers__properties()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local props = plugin.collisions[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    --====================
    -- Object Layer Shapes
    --====================

    -- Rectangle

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].object.shape
        lu.assertEquals(shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals({object.x, object.y}, {0, 0})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.width, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.height, 17)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__rectangle__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(#object.polygon, 4)
    end

    -- Point

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__points_ignored()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        for _, collision in ipairs(plugin.collisions) do
            if collision.object.shape == "point" then
                lu.fail("point objects on layers with box2d_collidable=true should be ignored by Box2D plugin")
            end
        end
    end

    -- Ellipse

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)

        local collisions = plugin:getCollision(2)
        for i = 1, #collisions do
            local object = collisions[i].object
            lu.assertEquals(object.shape, "ellipse")
        end
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)

        local collisions = plugin:getCollision(2)
        for i = 2, #collisions do
            local shape = collisions[i].shape
            lu.assertEquals(shape:type(), "PolygonShape")
        end
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(2)[1].object
        lu.assertEquals({object.x, object.y}, {64, 0})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(2)[1].object
        lu.assertEquals(object.width, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(2)[1].object
        lu.assertEquals(object.height, 17)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(2)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__ellipse__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(2)[1].object
        lu.assertEquals(#object.polygon, 36)
    end

    -- Polyline (edge)

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals(object.shape, "polyline")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(3)[1].shape
        lu.assertEquals(shape:type(), "EdgeShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals({object.x, object.y}, {0, 48})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals(object.width, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals(object.height, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__edge_polyline__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(3)[1].object
        lu.assertEquals(#object.polygon, 2)
    end

    -- Polyline (chain)

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals(object.shape, "polyline")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(4)[1].shape
        lu.assertEquals(shape:type(), "ChainShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals({object.x, object.y}, {32, 48})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals(object.width, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals(object.height, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__chain_polyline__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(4)[1].object
        lu.assertEquals(#object.polygon, 3)
    end

    -- Polygon

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals(object.shape, "polygon")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(5)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals({object.x, object.y}, {64, 32})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals(object.width, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals(object.height, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__polygon__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(5)[1].object
        lu.assertEquals(#object.polygon, 4)
    end

    -- Tile Object

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals(object.shape, "tileobject")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__box2d_shape()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(6)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__xy()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals({object.x, object.y}, {0, 80 + object.height})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__width()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals(object.width, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__height()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals(object.height, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__rotation()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals(object.rotation, math.rad(45))
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_object__polygon()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local object = plugin:getCollision(6)[1].object
        lu.assertEquals(#object.polygon, 4)
    end

    -------------------------------
    -- Map Object Collision Objects
    -------------------------------

    -- Note: Individual map objects on object layers can have box2d_collidable=true. Verify
    -- one collision object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 38)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__box2d_shape()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__fixture()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__body()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__properties()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)
        local props = plugin:getCollision(1)[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__shape()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__xy()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(2)[1].object

        lu.assertEquals({object.x, object.y}, {48, 0})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__width()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, tileset.tilewidth)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__height()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local tileset = map:getTileSet(1)
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, tileset.tileheight)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__rotation()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__objects__object__polygon()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(#object.polygon, 4)
    end

    -------------------------------------
    -- Tile Object Tile Collision Objects
    -------------------------------------

    -- Note: Tile Objects can have tiles with box2d_collidable=true. Verify one collision
    -- object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(object_layer__tile_objects)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 24)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__box2d_shape()
        local map = MapFactory(object_layer__tile_objects)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__fixture()
        local map = MapFactory(object_layer__tile_objects)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__body()
        local map = MapFactory(object_layer__tile_objects)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__properties()
        local map = MapFactory(object_layer__tile_objects)
        local plugin = _load_plugin(map)
        local props = plugin:getCollision(1)[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__shape()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__xy()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        -- Note: For whatever reason, Tiled chooses to use the lower left corner only for the
        -- tile object origin, but the Box2DPlugin uses the top right corner. Adjust accordingly.
        lu.assertEquals({object.x, object.y}, {0, 0})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__width()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__height()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, 16)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__rotation()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_objects__object__polygon()
        local map = MapFactory(object_layer__objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(#object.polygon, 4)
    end

    -------------------------------------------
    -- Tile Object Map Object Collision Objects
    -------------------------------------------

    -- Note: Tile Objects can have map objects associated with the tile. The map objects can then
    -- create collision objects so long as the tile does not have the box2d_collidable=true flag.
    -- Verify one collision object from list and  make sure it is correct.

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 9)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__box2d_shape()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__fixture()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__body()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__properties()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)
        local props = plugin:getCollision(1)[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__shape()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__xy()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(2)[1].object

        lu.assertEquals({object.x, object.y}, {26, 36})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__width()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, 5)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__height()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, 6)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__rotation()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__object_layers__tile_map_objects__object__polygon()
        local map = MapFactory(object_layer__map_objects)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(#object.polygon, 4)
    end

    --========================
    --==[[ Image Layers ]]==--
    --========================

    --------------------------
    -- Image Collision Objects
    --------------------------

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 1)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__box2d_shape()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)
        local shape = plugin:getCollision(1)[1].shape
        lu.assertEquals(shape:type(), "PolygonShape")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__fixture()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:type(), "Fixture")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__body()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:type(), "Body")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__properties()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)
        local props = plugin:getCollision(1)[1].properties
        lu.assertIsTrue(props:get("box2d_collidable"))
    end

    -- Object

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__shape()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object
        lu.assertEquals(object.shape, "rectangle")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__xy()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local layer = map:getLayer("image_layer__collidable=true")
        local object = plugin:getCollision(1)[1].object

        lu.assertEquals({object.x, object.y}, {layer.offsetx, layer.offsety})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__width()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.width, 80)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__height()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.height, 80)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__rotation()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(object.rotation, 0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__with_images__object__polygon()
        local map = MapFactory(image_layer__images)
        local plugin = _load_plugin(map)

        local object = plugin:getCollision(1)[1].object

        lu.assertEquals(#object.polygon, 4)
    end

    -----------
    -- No Image
    -----------

    function TestBox2DPlugin:test_box2d_plugin_init__image_layers__no_images__collidable_flag()
        -- See Map Details at bottom of this file for more details on map layouts.
        local map = MapFactory(image_layer__no_images)
        local plugin = _load_plugin(map)
        lu.assertEquals(#plugin.collisions, 0)
    end

    --==================
    --==[[ Bodies ]]==--
    --==================

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__default_collision_body_type()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin.collisions.body
        lu.assertEquals(body:getType(), "static")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__no_body_type_flags()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(1)[1].body
        lu.assertEquals(body:getType(), "static")
        lu.assertIsTrue(body == plugin.collisions.body)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__dynamic()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(2)[1].body
        lu.assertEquals(body:getType(), "dynamic")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__dynamic__xy()
        local map = MapFactory(bodies_map, {offsetx=10, offsety=20})
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(2)[1].body
        lu.assertEquals({body:getX(), body:getY()}, {10, 20})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__kinematic()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(3)[1].body
        lu.assertEquals(body:getType(), "kinematic")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__kinematic__xy()
        local map = MapFactory(bodies_map, {offsetx=10, offsety=20})
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(3)[1].body
        lu.assertEquals({body:getX(), body:getY()}, {10, 20})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__static()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(4)[1].body
        lu.assertEquals(body:getType(), "static")
        lu.assertIsFalse(body == plugin.collisions.body)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__static_xy()
        local map = MapFactory(bodies_map, {offsetx=10, offsety=20})
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(4)[1].body
        lu.assertEquals({body:getX(), body:getY()}, {10, 20})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__dynamic_has_priority_over_kinematic_and_static()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(5)[1].body
        lu.assertEquals(body:getType(), "dynamic")
    end

    function TestBox2DPlugin:test_box2d_plugin_init__bodies__kinematic_has_priority_over_static()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        local body = plugin:getCollision(6)[1].body
        lu.assertEquals(body:getType(), "kinematic")
    end

    --====================
    --==[[ Fixtures ]]==--
    --====================

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__default_friction()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertAlmostEquals(fixture:getFriction(), 0.2, 0.00001)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__friction()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(2)[1].fixture
        lu.assertEquals(fixture:getFriction(), 1.5)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__default_restitution()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals(fixture:getRestitution(), 0.0)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__restitution()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(2)[1].fixture
        lu.assertEquals(fixture:getRestitution(), 2.5)
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__default_sensor()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertIsFalse(fixture:isSensor())
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__sensor()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(2)[1].fixture
        lu.assertIsTrue(fixture:isSensor())
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__default_filter_data()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(1)[1].fixture
        lu.assertEquals({fixture:getFilterData()}, {1, 0xFFFF, 0})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__filter_data()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)
        local fixture = plugin:getCollision(2)[1].fixture
        lu.assertEquals({fixture:getFilterData()}, {2, 0xFF, 5})
    end

    function TestBox2DPlugin:test_box2d_plugin_init__fixtures__user_data()
        local map = MapFactory(fixtures_map)
        local plugin = _load_plugin(map)

        local collision = plugin:getCollision(1)[1]
        local fixture = collision.fixture

        lu.assertIsTrue(fixture:getUserData() == collision)
    end

    -------------------------------------------------------------------------------------

    --[[ Box2DPlugin:getWorld ]]

    function TestBox2DPlugin:test_box2d_plugin_get_world()
        local map = MapFactory(tile_layer__layers)
        local world = love.physics.newWorld(0, 0)
        local plugin = _load_plugin(map, world)
        lu.assertIsTrue(plugin:getWorld() == world)
    end

    --[[ Box2DPlugin:getCollision ]]

    function TestBox2DPlugin:test_box2d_plugin_get_collision()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local collisions = plugin:getCollision(2)

        lu.assertIsTable(collisions)
        lu.assertEquals(#collisions, 34)
    end

    function TestBox2DPlugin:test_box2d_plugin_get_collision__id_less_than_1()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local collisions = plugin:getCollision(0)

        lu.assertEquals(collisions, {})
    end

    function TestBox2DPlugin:test_box2d_plugin_get_collision__id_greater_than_number_collisions()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        local collisions = plugin:getCollision(plugin.nextcollisionid)

        lu.assertEquals(collisions, {})
    end

    function TestBox2DPlugin:test_box2d_plugin_get_collision__param1_not_number()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertErrorMsgContains("getCollision : id parameter must be a number type",
            plugin.getCollision, plugin, "")
    end

    --[[ Box2DPlugin:getCollisions ]]

    function TestBox2DPlugin:test_box2d_plugin_get_collisions()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        lu.assertIsTrue(plugin:getCollisions() == plugin.collisions)
    end

    --[[ Box2DPlugin:destroyCollision ]]

    function TestBox2DPlugin:test_box2d_plugin_destroy_collision()
        local map = MapFactory(object_layer__layers)
        local plugin = _load_plugin(map)

        -- Destroy the ellipse object.
        plugin:destroyCollision(2)
        lu.assertEquals(#plugin.collisions, 6)
    end

    function TestBox2DPlugin:test_box2d_plugin_destroy_collision__destroy_new_bodies()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)

        -- Destroy the ellipse object.
        plugin:destroyCollision(7)
        lu.assertEquals(#plugin.collisions, 6)
    end

    function TestBox2DPlugin:test_box2d_plugin_destroy_collision__id_less_than_one()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        plugin:destroyCollision(0)
        lu.assertEquals(#plugin.collisions, 38)
    end

    function TestBox2DPlugin:test_box2d_plugin_destroy_collision__id_greater_than_next_collision_id()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        plugin:destroyCollision(plugin.nextcollisionid)
        lu.assertEquals(#plugin.collisions, 38)
    end

    function TestBox2DPlugin:test_box2d_plugin_destroy_collision__param1_not_number()
        local map = MapFactory(bodies_map)
        local plugin = _load_plugin(map)
        lu.assertErrorMsgContains("destroyCollision : id parameter must be a number type",
            plugin.destroyCollision, plugin, "")
    end

    --[[ Box2DPlugin:destroyCollisions ]]

    function TestBox2DPlugin:test_box2d_plugin_destroy_collisions()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        plugin:destroyCollisions()
        lu.assertEquals(plugin.collisions, {body=plugin.collisions.body})
    end

    function TestBox2DPlugin:test_box2d_plugin_destroy_collisions__default_body_not_destroyed()
        local map = MapFactory(tile_layer__layers)
        local plugin = _load_plugin(map)
        plugin:destroyCollisions()
        local body = plugin.collisions.body

        -- If we can make at least one call on the Body object, then we know it's not destroyed.
        lu.assertEquals({body:getX(), body:getY()}, {0, 0})
    end

--=======================
--==[[ Map Details ]]==--
--=======================

--------------------------
--- tile_layer_5x5__layers
--------------------------
    -- The map contains:
        -- 1 layer with box2d_collidable=true with 5 tile instances
            -- One of the tile instances has a tile with box2d_collidable=true
            -- One of the tile instances has a tile object with box2d_collidable=true
        -- 1 layer with box2d_collidable=false with 5 tile instances
        -- 1 layer with box2d_collidable=true with 0 tile instances
        -- 1 layer without a box2d_collidable flag and 5 tile instances

    -- There should be 5 collision object based on the above scenarios.
    -- Note: If a tile layer has a collidable flag set, then the collidable flag on tiles and tile objects
    --       is ignored, which prevents the tile instance from being added to the collision map twice.

-------------------------------
-- tile_layer_5x5__tile_objects
-------------------------------
    -- The map contains:
        -- 1 tile instance with:
            -- (+1) 1 map object with box2d_collidable=true
            -- (+0) 1 map object with box2d_collidable=false
            -- (+0) 1 map object with no box2d_collidable flag
        -- 1 tile instance with:
            -- (+0) 1 map object with no box2d_collidable flag
        -- 1 tile that has not been used as a tile instance:
            -- (+0) 1 map object with box2d_collidable=true
            -- (+0) 1 map object with box2d_collidable=false
            -- (+0) 1 map object with no box2d_collidable flag
    -- There should only be 1 collision object based on the above scenarios.

-------------------------
--- tile_layer_5x5__tiles
-------------------------
    -- The map contains 2 layers, both layers with:
        -- (+1) 1 tile instance using a tile with box2d_collidable=true
        -- (+0) 1 tile instnace using a tile with box2d_collidable=false
        -- (+0) 1 tile instance using a tile without box2d_collidable flag
        -- (+0) 1 tile that contains box2d_collidable=true, but is not used as an instance
    -- There should be 2 collision objects created based on the above scenarios (one for each layer).

----------------------------
--- object_layer_5x5__layers
----------------------------
    -- The map contains:
        -- 1 object layer with box2d_collidable=true and seven different objects of different shapes
            -- One of the objects has box2d_collidable=true
            -- One of the objects has box2d_collidbale=false
        -- 1 object layer with box2d_collidable=false
        -- 1 object_layer with no box2d_collidable

    -- Note: If an object layer has a collidable flag set, then the collidable flag on map objects
    --       is ignored, which prevents the object from being added to the collision map twice.

    -- # collision objects on collidable layer:
    -------------------------------------------
    -- rectangle        =  1
    -- ellipse          = 34
    -- polyline (edge)  =  1
    -- polyline (chain) =  1
    -- polygon          =  2
    -- tile object      =  1
    --=============================
    -- Total:             40

-----------------------------
--- object_layer_5x5__objects
-----------------------------
    -- The map contains:
        -- 1 object layer with each object containing box2d_collidable=true
        -- 1 object layer with each object containing box2d_collidable=false
        -- 1 object_layer with each object having no box2d_collidable

    -- # collision objects on collidable layer:
    -------------------------------------------
    -- rectangle        =  1
    -- ellipse          = 32
    -- polyline (edge)  =  1
    -- polyline (chain) =  1
    -- polygon          =  2
    -- tile object      =  1
    --=============================
    -- Total:             38

----------------------------------
--- object_layer_5x5__tile_objects
----------------------------------
    -- The map contains:
        -- (+1) 1 tile object with box2d_collidable=true
        -- (+0) 1 tile object with box2d_collidable=false
        -- (+1) 1 tile object using a tile with box2d_collidable=true without tile objects
        -- (+0) 1 tile object using a tile with box2d_collidable=false
        -- (+0) 1 tile object using a tile without box2d_collidable, but with objects with box2d_collidable=true:
            -- rectangle        = +1
            -- ellipse          = +3
            -- polyline (edge)  = +1
            -- polyline (chain) = +1
            -- polygon          = +2
        -- (+0) tile object using a tile with box_collidable=true and objects that do not have box2d_collidable
            -- rectangle        = +1
            -- ellipse          = +10
            -- polyline (edge)  = +1
            -- polyline (chain) = +1
            -- polygon          = +1

    -- The total number of collision object should be 24 based on the above scenarios.
    -- Note: Ellipses have different numbers of collision objects based on their shape and size.
    --       They range from a minimum of 3 to a maximum of 64.

----------------------------------------------
--- object_layer_5x5__tile_object__map_objects
----------------------------------------------
    -- The map contains:
        -- 1 object layer with one tile object that contains the following objects with box2d_collidable=true:
            -- rectangle        = +1
            -- ellipse          = +4
            -- polyline (edge)  = +1
            -- polyline (chain) = +1
            -- polygon          = +2

    -- The total number of collision objects should be 9 based on the above scenarios.
    -- Note: Ellipses have different numbers of collision objects based on their shape and size.
    --       They range from a minimum of 3 to a maximum of 64.
    -- Note: Polygons are separated into triangluar shapes where each triangle is given a collision object.

---------------------------
--- image_layer_5x5__images
---------------------------
    -- The map contains:
        -- 1 image layer with box2d_collidable=true
        -- 1 image layer with box2d_collidable=false
        -- 1 image layer without a box2d_collidable property

-----------------------------
--- image_layer_5x5__no_image
-----------------------------
    -- The map contains:
        -- 1 image layer with box2d_collidable=true
        -- 1 image layer with box2d_collidable=false
        -- 1 image layer without a box2d_collidable property
    -- None of the image layers have any images associated with them, so the number of collision objects
    ---should be 0 based on the above scenarios.




























