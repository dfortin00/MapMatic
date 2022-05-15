local utils = require("../../../mapmatic/utils")

local mapdir = 'assets/maps/orthogonal/'
local object_10x10 = mapdir .. 'object_10x10_ts1'

TestMapMaticMapObject = {}

    function TestMapMaticMapObject:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__class_name()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        local object = layer:getObject("object_1")
        lu.assertEquals(object:type(), "MapObject")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__type_of()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        local object = layer:getObject("object_1")
        lu.assertIsTrue(object:typeOf("TObject"))
    end

    --[[ MapObject:init ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_init__owner()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        local object = layer:getObject("object_1")
        lu.assertIsTrue(object.owner == layer)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__name__no_name()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_5")
        local object = layer:getObjects()[1]
        lu.assertEquals(object.name, "")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rotation_in_radians()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals(object.rotation, math.rad(45))
    end

    --===========
    -- Rectangles
    --===========

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect")
        lu.assertEquals(rect.shape, "rectangle")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect")
        lu.assertEquals({rect.x, rect.y}, {0, 64})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local object = layer:getObject("object_4")
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({object.x, object.y}, {32, 32})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__vertices_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local vertex = layer:getObject("object_4"):getVertices()[1]
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({vertex.x, vertex.y}, {32 + 10, 32 + 20})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__width_height()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect")
        lu.assertEquals({rect.width, rect.height}, {16, 32})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect_w_rotation")
        lu.assertEquals(rect.rotation, math.rad(45))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__vertex_list()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect")
        lu.assertEquals(rect.rectangle, {{x=0, y=64}, {x=16, y=64}, {x=16, y=96}, {x=0, y=96}})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__rectangle__vertex_list_with_rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local rect = layer:getObject("rect_w_rotation")

        local expected = {{x=32, y=64}, {x=48, y=80}, {x=32, y=96}, {x=16, y=80}}

        for index, coord in ipairs(expected) do
            lu.assertAlmostEquals(rect.rectangle[index].x, coord.x, 0.001)
            lu.assertAlmostEquals(rect.rectangle[index].y, coord.y, 0.001)
        end
    end

    --=========
    -- Ellipses
    --=========

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli")
        lu.assertEquals(elli.shape, "ellipse")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli")
        lu.assertEquals({elli.x, elli.y}, {64, 80})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local elli = layer:getObject("elli")
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({elli.x, elli.y}, {80, 64})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__width_height()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli")
        lu.assertEquals({elli.width, elli.height}, {16, 32})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli_w_rotation")
        lu.assertEquals(elli.rotation, math.rad(90))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__default_num_vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli_w_rotation")

        -- Default number of vertices for large ellipses:
        -- 64 vertices for ellipse + 1 for center point + 1 for repeat of first point to close off circle = 66 vertices.
        lu.assertEquals(#elli.ellipse, 66)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__first_vertex_is_center_point()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli")
        lu.assertEquals(elli.ellipse[1], {x = elli.x + elli.width * 0.5, y = elli.y + elli.height * 0.5})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__ellipse__last_vertex_equals_first_vertex()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local elli = layer:getObject("elli")
        lu.assertEquals(elli.ellipse[2], elli.ellipse[#elli.ellipse])
    end

    --=========
    -- Polygons
    --=========

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("poly")
        lu.assertEquals(poly.shape, "polygon")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("poly")
        lu.assertEquals({poly.x, poly.y}, {64, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local polygon = layer:getObject("poly")
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({polygon.x, polygon.y}, {32, 80})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__vertices_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local vertex = layer:getObject("poly"):getVertices()[1]
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({vertex.x, vertex.y}, {32 + 10, 80 + 20})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("poly_w_rotation")
        lu.assertEquals(poly.rotation, math.rad(45))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__num_vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("poly")
        lu.assertEquals(#poly.polygon, 8)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polygon__vertex_list()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("poly")
        local x,y = poly.x, poly.y

        lu.assertEquals(poly.polygon, {
            { x = 0   + x, y = 0  + y},
            { x = -16 + x, y = 16 + y},
            { x = 0   + x, y = 32 + y},
            { x = 0   + x, y = 48 + y},
            { x = 16  + x, y = 48 + y},
            { x = 16  + x, y = 32 + y},
            { x = 32  + x, y = 16 + y},
            { x = 16  + x, y = 0  + y}
        })
    end

    --==========
    -- Polylines
    --==========

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local pline = layer:getObject("pline")
        lu.assertEquals(pline.shape, "polyline")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline_xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local pline = layer:getObject("pline")
        lu.assertEquals({pline.x, pline.y}, {16, 128})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local polyline = layer:getObject("pline")
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({polyline.x, polyline.y}, {64, 96})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__vertices_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local vertex = layer:getObject("pline"):getVertices()[1]
        -- The x,y of the object does not get changed, only the vertices get affected by the offset.
        lu.assertEquals({vertex.x, vertex.y}, {64 + 10, 96 + 20})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("pline_w_rotation")
        lu.assertEquals(poly.rotation, math.rad(90))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__num_vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local poly = layer:getObject("pline")
        lu.assertEquals(#poly.polyline, 4)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__vertex_list()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local pline = layer:getObject("pline")
        local x,y = pline.x, pline.y

        lu.assertEquals(pline.polyline, {
            { x = 0  + x, y = 0  + y },
            { x = 16 + x, y = 16 + y },
            { x = 32 + x, y = 0  + y },
            { x = 48 + x, y = 16 + y }
        })
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__polyline__vertex_list_with_rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local pline = layer:getObject("pline_w_rotation")

        lu.assertEquals(pline.polyline, {
            { x = 96, y = 112 },
            { x = 80, y = 128 },
            { x = 96, y = 144 },
            { x = 80, y = 160 }
        })
    end

    --=======
    -- Points
    --=======

    function TestMapMaticMapObject:test_mapmatic_map_object_init__point__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local p = layer:getObject("p")
        lu.assertEquals(p.shape, "point")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__point__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local p = layer:getObject("p")
        lu.assertEquals({p.x, p.y}, {128, 96})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__point__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local point = layer:getObject("p")
        -- The x,y of the object does not get changed by the offset.
        lu.assertEquals({point.x, point.y}, {96, 32})
    end

    --=============
    -- Tile Objects
    --=============

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tileobject = layer:getObject("tileobject1")
        lu.assertEquals(tileobject.shape, "tileobject")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tileobject = layer:getObject("tileobject1")
        lu.assertEquals({tileobject.x, tileobject.y}, {112, 144 + tileobject:getHeight()})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__xy_with_layer_offset()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        local tileobject = layer:getObject("tileobject")
        lu.assertEquals({tileobject.x, tileobject.y}, {112, 64 + tileobject:getHeight()})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__width_height()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject1")
        lu.assertEquals({tile.width, tile.height}, {16, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject2")
        lu.assertEquals(tile.rotation, math.rad(45))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__tile_gid()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject1")
        lu.assertEquals(tile.gid, 34)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__flip_scaling()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject2")
        lu.assertEquals({tile.sx, tile.sy}, {-1, -1})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__flip_flags__horizontal()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject2")
        lu.assertEquals(utils.math.bitAND(tile.gid, 0x80000000), 0x80000000)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__flip_flags__vertical()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject2")
        lu.assertEquals(utils.math.bitAND(tile.gid, 0x40000000), 0x40000000)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__animation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject1")
        lu.assertNotIsNil(tile.animation)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_init__tile_object__animation_added_to_map_lookup_table()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local tile = layer:getObject("tileobject1")
        lu.assertIsTrue(map.animations["object_layer_3"][1] == tile)
    end

    -------------------------------

    --[[ MapObject:getGid ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_gid__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        lu.assertEquals(object:getGid(), object.tile.gid)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_gid__shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        lu.assertIsNil(object:getGid())
    end

    --[[ MapObject:getOwner ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_owner__object_layer()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertIsTrue(object:getOwner() == layer)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_owner__tile()
        local map = MapFactory(object_10x10)
        local tile = map:getTile(1)
        local object = tile:getObject("tile_object")
        lu.assertIsTrue(object:getOwner() == tile)
    end

    --[[ MapObject:getTile ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_tile__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertIsTrue(object:getTile() == map.tiles[34])
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_tile__not_tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertIsNil(object:getTile())
    end

    --[[ MapObject:getShape ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_shape()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getShape(), "rectangle")
    end

    --[[ MapObject:getVertices ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_vertices__rectangle()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        local vertices = object:getVertices()
        lu.assertEquals(#vertices, 4)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_vertices__ellipse()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("elli")
        local vertices = object:getVertices()
        lu.assertEquals(#vertices, 66)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_vertices__polygon()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("poly")
        local vertices = object:getVertices()
        lu.assertEquals(#vertices, 8)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_vertices__polyline()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("pline")
        local vertices = object:getVertices()
        lu.assertEquals(#vertices, 4)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_get_vertices__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        local vertices = object:getVertices()
        lu.assertEquals(#vertices, 0)
    end

    --[[ MapObject:getObjectType ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_object_type()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getObjectType(), "TestType")
    end

    --[[ MapObject:setPosition ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_set_position__shape__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setPosition(10, 20)

        lu.assertEquals({object.x, object.y}, {10, 20})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_position__shape__vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setPosition(10, 20)

        lu.assertEquals(object.rectangle, {
            {x=10, y=20},
            {x=26, y=20},
            {x=26, y=52},
            {x=10, y=52}
        })
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_position__tile()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setPosition(10, 20)

        lu.assertEquals({object.x, object.y}, {10, 20})
    end

    --[[ MapObject:setX ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_set_x__shape__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setX(10)

        lu.assertEquals({object.x, object.y}, {10, 64})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_x__shape__vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setX(10)

        lu.assertEquals(object.rectangle, {
            {x=10, y=64},
            {x=26, y=64},
            {x=26, y=96},
            {x=10, y=96}
        })
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_x__tile()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setX(10)

        lu.assertEquals({object.x, object.y}, {10, 144 + object:getHeight()})
    end

    --[[ MapObject:setY ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_set_y__shape__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setY(20)

        lu.assertEquals({object.x, object.y}, {0, 20})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_y__shape__vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setY(20)

        lu.assertEquals(object.rectangle, {
            {x= 0, y=20},
            {x=16, y=20},
            {x=16, y=52},
            {x= 0, y=52}
        })
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_set_y__tile()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setY(20)

        lu.assertEquals({object.x, object.y}, {112, 20})
    end

    --[[ MapObject:moveBy ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_move_by__shape__xy()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:moveBy(10, 20)

        lu.assertEquals({object.x, object.y}, {10, 84})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_move_by__shape__vertices()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:moveBy(10, 20)

        lu.assertEquals(object.rectangle, {
            {x=10, y=84},
            {x=26, y=84},
            {x=26, y=116},
            {x=10, y=116}
        })
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_move_by__tile()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:moveBy(10, 20)

        lu.assertEquals({object.x, object.y}, {122, 164 + object:getHeight()})
    end

    --[[ MapObject:isVisible ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_is_visible__true()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local object = layer:getObject("rect_visible")
        lu.assertIsTrue(object:isVisible())
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_is_visible__false()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local object = layer:getObject("rect_invisible")
        lu.assertIsFalse(object:isVisible())
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_is_visible__owner_not_visible()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")

        layer:setVisibility(false)
        local object = layer:getObject("rect_visible")

        lu.assertIsFalse(object:isVisible())
    end

    --[[ MapObject:hasAnimation ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_has_animation__true()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        lu.assertIsTrue(object:hasAnimation())
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_has_animation__false()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tile_no_anim")

        lu.assertIsFalse(object:hasAnimation())
    end

    function TestMapMaticMapObject:test_mapmatic_map_object_has_animation__not_tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        lu.assertIsFalse(object:hasAnimation())
    end

    --[[ MapObject:getAnimation ]]

    function TestMapMaticMapObject:test_mapmatic_map_object_get_animation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        local anim = object:getAnimation()

        lu.assertEquals(anim:type(), "TileAnimation")
    end

    --======================================
    -- TObject
    --======================================

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_id()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        lu.assertEquals(object:getId(), 24)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_name()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        lu.assertEquals(object:getName(), "tileobject1")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_name()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setName("new_object_name")

        lu.assertEquals(object:getName(), "new_object_name")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_position()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect_w_rotation")
        lu.assertEquals({object:getPosition()}, {32, 64})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect_w_rotation")
        lu.assertEquals(object:getX(), 32)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect_w_rotation")
        lu.assertEquals(object:getY(), 64)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect_w_rotation")
        lu.assertEquals(object:getRotation(), math.rad(45))
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_scale()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals({object:getScale()}, {-1, -1})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_scale_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals(object:getScaleX(), -1)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_scale_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals(object:getScaleY(), -1)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals({object:getOrigin()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals({object:getOrigin()}, {0, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin__tile_object_with_rotation()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals({object:getOrigin()}, {16, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getOriginX(), 0)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin_x__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")
        lu.assertEquals(object:getOriginX(), 16)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getOriginY(), 0)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_origin_y__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals(object:getOriginY(), 16)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setOrigin(8, 8)

        lu.assertEquals({object:getOrigin()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOrigin(8, 8)

        lu.assertEquals({object:getOrigin()}, {8, 8})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setOriginX(8)

        lu.assertEquals({object:getOrigin()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin_x__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOriginX(8)

        lu.assertEquals({object:getOrigin()}, {8, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setOriginY(8)

        lu.assertEquals({object:getOrigin()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_origin_y__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject2")

        object:setOriginY(8)

        lu.assertEquals({object:getOrigin()}, {16, 8})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_draw_coords()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        lu.assertEquals({object:getDrawCoords()}, {0, 64, 0, 1, 1, 0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_draw_coords__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        lu.assertEquals({object:getDrawCoords()}, {112, 128 + object:getHeight(), 0, 1, 1, 0, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_dimensions()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals({object:getDimensions()}, {16, 32})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_width()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getWidth(), 16)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_height()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals(object:getHeight(), 32)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_rect()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")
        lu.assertEquals({object:getRect()}, {0, 64, 16, 32})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_rect__tile_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals({object:getRect()}, {112, 128 + object:getHeight(), 16, 16})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_offsets()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals({object:getOffsets()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_offset_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals(object:getOffsetX(), 0)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_offset_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals(object:getOffsetY(), 0)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_offsets()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOffsets(10, 20)

        lu.assertEquals({object:getOffsets()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_offset_x()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOffsetX(10)

        lu.assertEquals({object:getOffsets()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_offset_y()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOffsetY(10)

        lu.assertEquals({object:getOffsets()}, {0, 0})
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_visibility__true()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local object = layer:getObject("rect_invisible")

        object:setVisibility(true)
        lu.assertIsTrue(object.visible)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_visibility__false()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local object = layer:getObject("rect_visible")

        object:setVisibility(false)
        lu.assertIsFalse(object.visible)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_opacity()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")
        lu.assertEquals(object:getOpacity(), 1 )
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_opacity()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("tileobject1")

        object:setOpacity(0.5)

        lu.assertEquals(object:getOpacity(), 1 )
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_property()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        lu.assertEquals(object:getProperty("extra_prop"), "test value")
        lu.assertEquals(object:getProperty("layer_prop"), "test layer value")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__set_property()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setProperty("unit_test_prop", "test value")

        lu.assertEquals(object.properties.props["unit_test_prop"].value, "test value")
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__get_num_properties()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setProperty("unit_test_prop", "test value")

        lu.assertEquals(object:getNumProperties(), 4)
    end

    function TestMapMaticMapObject:test_mapmatic_map_object__tobject__has_property_key()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_3")
        local object = layer:getObject("rect")

        object:setProperty("unit_test_prop", "test value")

        lu.assertIsTrue(object:hasPropertyKey("unit_test_prop"))
    end
















