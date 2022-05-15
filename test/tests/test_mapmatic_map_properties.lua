
-- In some cases, it's easier to test the class directly rather than go through the Map interface.
local MapProperties = require('../../../mapmatic/mapfactory/MapProperties')
local utils = require("../../../mapmatic/utils")

local f = function() end
local i = love.graphics.newImage("assets/portrait.png")
local p = {properties={
    ["bool_prop"] = false,
    ["color_prop"] = "#ffffffff",
    ["file_prop"] = "../../mage_portrait.png",
    ["float_prop"] = 1.4,
    ["int_prop"] = 2,
    ["object_prop"] = { id = 1 },
    ["string_prop"] = "string.value",
    ["table_prop"] = {},
    ["function_prop"] = f,
    ["userdata_prop"] = i,
}}

local parent = { properties={
    ["parent_bool_prop"] = true,
    ["parent_color_prop"] = "#00000000",
    ["parent_file_prop"] = "../../portrait.png",
    ["parent_float_prop"] = 1.4,
    ["parent_int_prop"] = 2,
    ["parent_object_prop"] = { id = 2 },
    ["parent_string_prop"] = "parent.string.value",
    ["parent_table_prop"] = {},
    ["parent_function_prop"] = f,
    ["parent_userdata_prop"] = i,
}}

local mapdir      = 'assets/maps/orthogonal/'
local props_10x10 = mapdir .. 'props_10x10_ts1_tc1'

-----------------------------------------------

TestMapMaticMapProperties = {}

    function TestMapMaticMapProperties:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticMapProperties:test_mapmatic_properties__class_name()
        local props = MapProperties()
        lu.assertEquals(props:type(), "MapProperties")
    end

    --[[ MapProperties:init ]]

    --========
    -- Boolean
    --========

    function TestMapMaticMapProperties:test_mapmatic_properties_init__boolean()
        local props = MapProperties(p)
        local value = props.props["bool_prop"].value
        lu.assertIsBoolean(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__boolean__value()
        local props = MapProperties(p)
        local value = props.props["bool_prop"].value
        lu.assertIsFalse(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__boolean__type()
        local props = MapProperties(p)
        local ptype = props.props["bool_prop"].type
        lu.assertEquals(ptype, "boolean")
    end

    --=======
    -- Number
    --=======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__number()
        local props = MapProperties(p)
        local value = props.props["int_prop"].value
        lu.assertIsNumber(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__number__value()
        local props = MapProperties(p)
        local value = props.props["int_prop"].value
        lu.assertEquals(value, 2)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__number__type()
        local props = MapProperties(p)
        local ptype = props.props["int_prop"].type
        lu.assertEquals(ptype, "number")
    end

    --======
    -- Color
    --======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__color()
        local props = MapProperties(p)
        local value = props.props["color_prop"].value
        lu.assertIsTrue(utils.colors.validateColor(value))
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__color__value()
        local props = MapProperties(p)
        local value = props.props["color_prop"].value

        lu.assertEquals(value, {1, 1, 1, 1, byte=false})
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__color__type()
        local props = MapProperties(p)
        local ptype = props.props["color_prop"].type
        lu.assertEquals(ptype, "color")
    end

    --=====
    -- File
    --=====

    function TestMapMaticMapProperties:test_mapmatic_properties_init__file()
        local props = MapProperties(p)
        local value = props.props["file_prop"].value
        lu.assertIsString(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__file__value()
        local props = MapProperties(p)
        local value = props.props["file_prop"].value

        lu.assertEquals(value, "../../mage_portrait.png")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__file__type()
        local props = MapProperties(p)
        local ptype = props.props["file_prop"].type
        lu.assertEquals(ptype, "file")
    end

    --=======
    -- Object
    --=======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object()
        local props = MapProperties(p)
        local value = props.props["object_prop"].value
        lu.assertIsTable(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object__value()
        local props = MapProperties(p)
        local value = props.props["object_prop"].value

        lu.assertEquals(value, {id=1})
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object__type()
        local props = MapProperties(p)
        local ptype = props.props["object_prop"].type
        lu.assertEquals(ptype, "object")
    end

    --=======
    -- String
    --=======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__string()
        local props = MapProperties(p)
        local value = props.props["string_prop"].value
        lu.assertIsString(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__string__value()
        local props = MapProperties(p)
        local value = props.props["string_prop"].value
        lu.assertEquals(value, "string.value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__string__type()
        local props = MapProperties(p)
        local ptype = props.props["string_prop"].type
        lu.assertEquals(ptype, "string")
    end

    --======
    -- Table
    --======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__table()
        local props = MapProperties(p)
        local value = props.props["table_prop"].value
        lu.assertIsTable(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__table__value()
        local props = MapProperties(p)
        local value = props.props["table_prop"].value
        lu.assertEquals(value, {})
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__table__type()
        local props = MapProperties(p)
        local ptype = props.props["table_prop"].type
        lu.assertEquals(ptype, "table")
    end

    --=========
    -- Function
    --=========

    function TestMapMaticMapProperties:test_mapmatic_properties_init__function()
        local props = MapProperties(p)
        local value = props.props["function_prop"].value
        lu.assertIsFunction(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__function__value()
        local props = MapProperties(p)
        local value = props.props["function_prop"].value
        lu.assertIsTrue(value == f)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__function__type()
        local props = MapProperties(p)
        local ptype = props.props["function_prop"].type
        lu.assertEquals(ptype, "function")
    end

    --=========
    -- Userdata
    --=========

    function TestMapMaticMapProperties:test_mapmatic_properties_init__userdata()
        local props = MapProperties(p)
        local value = props.props["userdata_prop"].value
        lu.assertIsUserdata(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__userdata__value()
        local props = MapProperties(p)
        local value = props.props["userdata_prop"].value
        lu.assertIsTrue(value == i)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__userdata__type()
        local props = MapProperties(p)
        local ptype = props.props["userdata_prop"].type
        lu.assertEquals(ptype, "Image")
    end

    --==============
    -- Class Objects
    --==============

    function TestMapMaticMapProperties:test_mapmatic_properties_init__table()
        local props = MapProperties({test="test value"})
        lu.assertEquals(props:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__class_object()
        local props = MapProperties({test="test value"})
        local props2 = MapProperties(props)

        lu.assertEquals(props2:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__properties__table()
        local props = MapProperties({properties={test="test value"}})
        lu.assertEquals(props:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__properties__class_object()
        local props = MapProperties({test="test value"})
        local props2 = MapProperties({properties=props})

        lu.assertEquals(props2:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__table()
        local props = MapProperties({}, {test="test value"})
        lu.assertEquals(props:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__class_object()
        local props = MapProperties({test="test value"})
        local props2 = MapProperties({}, props)

        lu.assertEquals(props2:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__properties__table()
        local props = MapProperties({}, {properties={test="test value"}})
        lu.assertEquals(props:get("test"), "test value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__properties__class_object()
        local props = MapProperties({test="test value"})
        local props2 = MapProperties({}, {properties=props})

        lu.assertEquals(props2:get("test"), "test value")
    end

    --=======
    -- Parent
    --=======

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__inherit_properties()
        local props = MapProperties(p, parent)
        local keys = utils.table.keys(props.props)
        lu.assertItemsEquals(keys, {
            "bool_prop",
            "int_prop",
            "float_prop",
            "string_prop",
            "table_prop",
            "color_prop",
            "file_prop",
            "object_prop",
            "function_prop",
            "userdata_prop",

            "parent_int_prop",
            "parent_color_prop",
            "parent_function_prop",
            "parent_userdata_prop",
            "parent_object_prop",
            "parent_file_prop",
            "parent_bool_prop",
            "parent_table_prop",
            "parent_string_prop",
            "parent_float_prop"
        })
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__parent_has_property_class()
        local parent2 = MapProperties(parent)
        local props = MapProperties(p, {properties=parent2})
        local value = props.props["parent_string_prop"].value
        lu.assertIsString(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__string()
        local props = MapProperties(p, parent)
        local value = props.props["parent_string_prop"].value
        lu.assertIsString(value)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__string__value()
        local props = MapProperties(p, parent)
        local value = props.props["parent_string_prop"].value
        lu.assertEquals(value, "parent.string.value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__string__type()
        local props = MapProperties(p, parent)
        local ptype = props.props["parent_string_prop"].type
        lu.assertEquals(ptype, "string")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__parent__parent_does_not_override()
        local parent2 = {properties = {
            ["string_prop"] = "parent override"
        }}

        local props = MapProperties(p, parent2)
        local value = props.props["string_prop"].value

        lu.assertEquals(value, "string.value")
    end

    -- Map

    function TestMapMaticMapProperties:test_mapmatic_properties_init__map_properties()
        local map = MapFactory(props_10x10)
        lu.assertEquals(map.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__map_properties__values()
        local map = MapFactory(props_10x10)
        local value = map.properties.props["map_string_prop"].value
        lu.assertEquals(value, "map string value")
    end

    --=================
    -- Layer Properties
    --=================

    -- Tile Layer

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_layer_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_layer_properties__values()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("tile_layer")
        local value = layer.properties.props["tile_layer_prop"].value
        lu.assertEquals(value, "tile layer value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_layer_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("tile_layer")
        local value = layer.properties.props["map_string_prop"].value
        lu.assertEquals(value, "map string value")
    end

    -- Object Layer

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object_layer_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object_layer_properties__values()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local value = layer.properties.props["object_layer_prop"].value
        lu.assertEquals(value, "object layer value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__object_layer_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local value = layer.properties.props["map_string_prop"].value
        lu.assertEquals(value, "map string value")
    end

    -- Image Layer

    function TestMapMaticMapProperties:test_mapmatic_properties_init__image_layer_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__image_layer_properties__values()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("image_layer")
        local value = layer.properties.props["image_layer_prop"].value
        lu.assertEquals(value, "image layer value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__image_layer_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("image_layer")
        local value = layer.properties.props["map_string_prop"].value
        lu.assertEquals(value, "map string value")
    end

    -- Group Layer

    function TestMapMaticMapProperties:test_mapmatic_properties_init__group_layer_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__group_layer_properties__values()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("group_layer")
        local value = layer.properties.props["group_layer_prop"].value
        lu.assertEquals(value, "group layer value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__group_layer_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("group_layer")
        local value = layer.properties.props["map_string_prop"].value
        lu.assertEquals(value, "map string value")
    end

    --==================
    -- Object Properties
    --==================

    -- Tile Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("cave_object")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("cave_object")
        local value = object.properties.props["tile_object_prop"].value

        lu.assertEquals(value, "tile object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("cave_object")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    -- Rectangle Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__rect_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("rect")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__rect_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("rect")
        local value = object.properties.props["rect_object_prop"].value

        lu.assertEquals(value, "rectangle object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__rect_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("rect")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    -- Ellipse Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ellipse_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("ellipse")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ellipse_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("ellipse")
        local value = object.properties.props["ellipse_object_prop"].value

        lu.assertEquals(value, "ellipse object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ellipse_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("ellipse")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    -- Point Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__point_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("point")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__point_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("point")
        local value = object.properties.props["point_object_prop"].value

        lu.assertEquals(value, "point object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__point_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("point")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    -- Polygon Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polygon_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polygon")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polygon_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polygon")
        local value = object.properties.props["polygon_object_prop"].value

        lu.assertEquals(value, "polygon object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polygon_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polygon")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    -- Polyline Object

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polyline_object_properties()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polyline")
        lu.assertEquals(object.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polyline_object_properties__value()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polyline")
        local value = object.properties.props["polyline_object_prop"].value

        lu.assertEquals(value, "polyline object value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__polyline_object_properties__inherits_layer()
        local map = MapFactory(props_10x10)
        local layer = map:getLayer("object_layer")
        local object = layer:getObject("polyline")
        local value = object.properties.props["object_layer_prop"].value

        lu.assertEquals(value, "object layer value")
    end

    --===================
    -- Tileset Properties
    --===================

    -- Tileset

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tileset_properties()
        local map = MapFactory(props_10x10)
        local tileset = map:getTileSet("world_tileset")
        lu.assertEquals(tileset.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tileset_properties__value()
        local map = MapFactory(props_10x10)
        local tileset = map:getTileSet("world_tileset")
        local value = tileset.properties.props["tileset_prop"].value

        lu.assertEquals(value, "tileset value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tileset_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local tileset = map:getTileSet("world_tileset")
        local value = tileset.properties.props["map_string_prop"].value

        lu.assertEquals(value, "map string value")
    end

    -- Tile Collection

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_collection_properties()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        lu.assertEquals(tilecollection.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_collection_properties__value()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        local value = tilecollection.properties.props["tile_collection_prop"].value

        lu.assertEquals(value, "tile collection value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tile_collection_properties__inherit_map()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        local value = tilecollection.properties.props["map_string_prop"].value

        lu.assertEquals(value, "map string value")
    end

    --================
    -- Tile Properties
    --================

    -- Tileset Tiles

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ts_tile_properties()
        local map = MapFactory(props_10x10)
        local tile = map:getTile(1)
        lu.assertEquals(tile.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ts_tile_properties__value()
        local map = MapFactory(props_10x10)
        local tile = map:getTile(1)
        local value = tile.properties.props["ts_tile_prop"].value

        lu.assertEquals(value, "tileset tile value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__ts_tile_properties__inherit_tileset()
        local map = MapFactory(props_10x10)
        local tile = map:getTile(1)
        local value = tile.properties.props["tileset_prop"].value

        lu.assertEquals(value, "tileset value")
    end

    -- Tile Collection Tiles

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tc_tile_properties()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        local tile = map:getTile(tilecollection:getFirstGid())
        lu.assertEquals(tile.properties:type(), "MapProperties")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tc_tile_properties__value()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        local tile = map:getTile(tilecollection:getFirstGid())
        local value = tile.properties.props["tc_tile_prop"].value

        lu.assertEquals(value, "tile collection tile value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_init__tc_tile_properties__inherit_tile_collection()
        local map = MapFactory(props_10x10)
        local tilecollection = map:getTileSet("collection_ts")
        local tile = map:getTile(tilecollection:getFirstGid())
        local value = tile.properties.props["tile_collection_prop"].value

        lu.assertEquals(value, "tile collection value")
    end

    --[[ MapProperties:getPropertyType ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__bool()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("bool_prop"), "boolean")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__color()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("color_prop"), "color")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__file()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("file_prop"), "file")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__number()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("int_prop"), "number")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__object()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("object_prop"), "object")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__string()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("string_prop"), "string")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__table()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("table_prop"), "table")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__function()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("function_prop"), "function")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__userdata()
        local props = MapProperties(p)
        lu.assertEquals(props:getPropertyType("userdata_prop"), "Image")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get_property_type__no_property()
        local props = MapProperties(p)
        lu.assertIsNil(props:getPropertyType("no_prop"))
    end

    --[[ MapProperties:numProperties ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_num_properties()
        local props = MapProperties(p)
        lu.assertEquals(props:getNumProperties(), 10)
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_num_properties__with_parent()
        local props = MapProperties(p, parent)
        lu.assertEquals(props:getNumProperties(), 20)
    end

    --[[ MapProperties:get ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_get()
        local props = MapProperties(p)
        lu.assertEquals(props:get("string_prop"), "string.value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_get__key_does_not_exist()
        local props = MapProperties(p)
        lu.assertIsNil(props:get("not_a_key"))
    end

    --[[ MapProperties:set ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_set__new_key()
        local props = MapProperties(p)
        props:set("new_prop", "new value")
        lu.assertEquals(props.props["new_prop"].value, "new value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_set__overwrite_existing_key()
        local props = MapProperties(p)
        props:set("string_prop", "new value")
        lu.assertEquals(props.props["string_prop"].value, "new value")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_set__remove_existing_key()
        local props = MapProperties(p)
        props:set("string_prop")
        lu.assertIsNil(props.props["string_prop"])
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_set__default_type()
        local props = MapProperties(p)
        props:set("new_prop", false)
        lu.assertEquals(props.props["new_prop"].type, "boolean")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_set__change_type()
        local props = MapProperties(p)
        props:set("string_prop", "new value", "entity")
        lu.assertEquals(props.props["string_prop"].type, "entity")
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_set__type_param_not_string()
        local props = MapProperties(p)
        lu.assertErrorMsgContains("set : property type parameter must be a string",
            props.set, props, "string_prop", "new value", {})
    end

    --[[ MapProperties:hasKey ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_has_key__true()
        local props = MapProperties(p)
        lu.assertIsTrue(props:hasKey("string_prop"))
    end

    function TestMapMaticMapProperties:test_mapmatic_properties_has_key__false()
        local props = MapProperties(p)
        lu.assertIsFalse(props:hasKey("not_a_key"))
    end

    --[[ MapProperties:keys ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_keys()
        local props = MapProperties(p, parent)
        lu.assertItemsEquals(props:keys(), {
            "bool_prop",
            "color_prop",
            "file_prop",
            "float_prop",
            "int_prop",
            "object_prop",
            "string_prop",
            "table_prop",
            "function_prop",
            "userdata_prop",
            "parent_bool_prop",
            "parent_color_prop",
            "parent_file_prop",
            "parent_float_prop",
            "parent_int_prop",
            "parent_object_prop",
            "parent_string_prop",
            "parent_table_prop",
            "parent_function_prop",
            "parent_userdata_prop"
        })
    end

    --[[ MapProperties:values ]]

    function TestMapMaticMapProperties:test_mapmatic_properties_values()
        local props = MapProperties(p, parent)
        lu.assertItemsEquals(props:values(), {
            false,
            {1, 1, 1, 1, byte=false},
            "../../mage_portrait.png",
            1.4,
            2,
            { id = 1 },
            "string.value",
            {},
            f,
            i,
            true,
            {0, 0, 0, 0, byte=false},
            "../../portrait.png",
            1.4,
            2,
            { id = 2 },
            "parent.string.value",
            {},
            f,
            i,
        })
    end





























