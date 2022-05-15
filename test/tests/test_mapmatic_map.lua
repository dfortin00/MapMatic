local utils = require("../../../mapmatic/utils")

local mapdir = 'assets/maps/orthogonal/'

-- Map variables
local empty_8x8_ortho                 = mapdir .. 'empty_8x8_ortho'
local parallax_origin                 = mapdir .. 'parallax_origin_5x5'
local layers_8x8_ortho                = mapdir .. 'layers_8x8_ortho'
local empty_10x6_ortho                = mapdir .. 'empty_10x6_ortho.lua'
local anim_8x8_ortho_ts1              = mapdir .. 'anim_8x8_ortho_ts1'
local parallax_no_origin              = mapdir .. 'parallax_no_origin_5x5'
local simple_8x8_ortho_ts1            = mapdir .. 'simple_8x8_ortho_ts1'
local simple_8x8_ortho_tc1            = mapdir .. 'simple_8x8_ortho_tc1'
local layer_8x8_ortho_ts1_anim        = mapdir .. 'layer_8x8_ortho_ts1_anim'
local simple_8x8_ortho_ts1_tc1        = mapdir .. 'simple_8x8_ortho_ts1_tc1'
local simple_8x8_ortho_tc1_w_gaps     = mapdir .. 'simple_8x8_ortho_tc1_w_gaps'
local empty_2x2_ortho__tilesize_10x20 = mapdir .. 'empty_2x2_ortho__tilesize_10x20.lua'

TestMapMaticMap = {}

    function TestMapMaticMap:tearDown()
        MapFactory:clearCache()
    end

    --[[ Map ]]

    function TestMapMaticMap:test_mapmatic_map__class_name()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals(map:type(), "Map")
    end

    function TestMapMaticMap:test_mapmatic_map__type_of()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertIsTrue(map:typeOf("Class"))
    end

    --[[ Map:init ]]

    function TestMapMaticMap:test_mapmatic_map_init__default_canvas_size()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals({map.canvas:getDimensions()}, {love.graphics.getWidth(), love.graphics.getHeight()})
    end

    function TestMapMaticMap:test_mapmatic_map_init__map_directory()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map.directory, mapdir)
    end

    function TestMapMaticMap:test_mapmatic_map_init__map_name()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map.mapname, "empty_10x6_ortho")
    end

    --=======
    -- Offset
    --=======

    function TestMapMaticMap:test_mapmatic_map_init__default_offset()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals({map.offsetx, map.offsety}, {0, 0})
    end

    function TestMapMaticMap:test_mapmatic_map_init__offset()
        local map = MapFactory(empty_8x8_ortho, {offsetx=10, offsety=20})
        lu.assertEquals({map.offsetx, map.offsety}, {10, 20})
    end

    --======
    -- Tiles
    --======

    function TestMapMaticMap:test_mapmatic_map_init__tiles__no_tilesets()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals(map.tiles, {})
    end

    function TestMapMaticMap:test_mapmatic_map_init__tiles__one_tileset()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals(#map.tiles, 64)
        lu.assertEquals(map.tiles[1]:type(), "Tile")
    end

    function TestMapMaticMap:test_mapmatic_map_init__tiles__one_tile_collection()
        local map = MapFactory(simple_8x8_ortho_tc1)
        lu.assertEquals(#map.tiles, 1)
        lu.assertEquals(map.tiles[1]:type(), "Tile")
    end

    function TestMapMaticMap:test_mapmatic_map_init__tiles__tile_collection_with_gaps()
        local map = MapFactory(simple_8x8_ortho_tc1_w_gaps)
        lu.assertEquals(utils.table.getn(map.tiles), 2)
        lu.assertItemsEquals(utils.table.keys(map.tiles), {1, 3})
    end

    --========
    -- Objects
    --========

    function TestMapMaticMap:test_mapmatic_map_init__objects__no_objects()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals(map.objects, {})
    end

    function TestMapMaticMap:test_mapmatic_map_init__objects__one_object()
        local map = MapFactory(simple_8x8_ortho_ts1)

        lu.assertEquals(utils.table.getn(map.objects.layers), 2)
        lu.assertEquals(map.objects.layers[map.nextobjectid - 1]:type(), "MapObject")
    end

    function TestMapMaticMap:test_mapmatic_map_init__objects__tile_objects()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals(utils.table.getn(map.objects.tiles), 1)
        lu.assertEquals(map.objects.tiles[1]:type(), "MapObject")
    end

    --===========
    -- Animations
    --===========

    function TestMapMaticMap:test_mapmatic_map_init__animations__no_animations()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals(map.animations, {})
    end

    function TestMapMaticMap:test_mapmatic_map_init__animations__tile_animations()
        local map = MapFactory(anim_8x8_ortho_ts1)
        lu.assertEquals(map.animations['background'][1]:type(), "TileInstance")
    end

    function TestMapMaticMap:test_mapmatic_map_init__animations__object_animations()
        local map = MapFactory(anim_8x8_ortho_ts1)
        lu.assertEquals(map.animations['entities'][1]:type(), "MapObject")
    end

    --=========
    -- Tilesets
    --=========

    function TestMapMaticMap:test_mapmatic_map_init__tilesets__no_tilesets()
        local map = MapFactory(empty_8x8_ortho)
        lu.assertEquals(map.tilesets, {})
    end

    function TestMapMaticMap:test_mapmatic_map_init__tilesets__one_tilesets()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals(#map.tilesets, 1)
        lu.assertEquals(map.tilesets[1]:type(), "TileSet")
    end

    --=======
    -- Layers
    --=======

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_tile_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[1].name, "tile_layer")
        lu.assertEquals(map.layers[1]:type(), "TileLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_object_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[2].name, "object_layer")
        lu.assertEquals(map.layers[2]:type(), "ObjectLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_image_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[3].name, "image_layer")
        lu.assertEquals(map.layers[3]:type(), "ImageLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_group_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[4].name, "group_layer")
        lu.assertEquals(map.layers[4]:type(), "GroupLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_child_tile_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[4].layers[2].name, "child_tile_layer")
        lu.assertEquals(map.layers[4].layers[2]:type(), "TileLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_child_object_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[4].layers[3].name, "child_object_layer")
        lu.assertEquals(map.layers[4].layers[3]:type(), "ObjectLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_child_image_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[4].layers[4].name, "child_image_layer")
        lu.assertEquals(map.layers[4].layers[4]:type(), "ImageLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_init__layers__build_child_group_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map.layers[4].layers[5].name, "child_group_layer")
        lu.assertEquals(map.layers[4].layers[5]:type(), "GroupLayer")
    end

    --============
    -- Layer Paths
    --============

    function TestMapMaticMap:test_mapmatic_map_init__layerpaths()
        local map = MapFactory(layers_8x8_ortho)
        local paths = utils.table.keys(map.layerpaths)
        lu.assertItemsEquals(paths, {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
            'tile_layer', 'object_layer', 'image_layer', 'group_layer',
            "group_layer.layer.with.dots",
            "group_layer.child_tile_layer",
            "group_layer.child_group_layer",
            "group_layer.child_group_layer.sub_layer",
            "group_layer.child_image_layer",
            "group_layer.child_object_layer",
            "empty_group"
        })
    end

    function TestMapMaticMap:test_mapmatic_map_init__layerpaths__indices()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertIsTrue(map.layerpaths[1] == map.layerpaths['tile_layer'])
        lu.assertIsTrue(map.layerpaths[2] == map.layerpaths['object_layer'])
        lu.assertIsTrue(map.layerpaths[3] == map.layerpaths['image_layer'])
        lu.assertIsTrue(map.layerpaths[4] == map.layerpaths['group_layer'])
        lu.assertIsTrue(map.layerpaths[5] == map.layerpaths['group_layer.layer.with.dots'])
        lu.assertIsTrue(map.layerpaths[6] == map.layerpaths['group_layer.child_tile_layer'])
        lu.assertIsTrue(map.layerpaths[7] == map.layerpaths['group_layer.child_object_layer'])
        lu.assertIsTrue(map.layerpaths[8] == map.layerpaths['group_layer.child_image_layer'])
        lu.assertIsTrue(map.layerpaths[9] == map.layerpaths['group_layer.child_group_layer'])
    end

    function TestMapMaticMap:test_mapmatic_map_init__layerpaths__tree_structure()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertIsTrue(map.layerpaths['tile_layer'] == map.layers[1])
        lu.assertIsTrue(map.layerpaths['object_layer'] == map.layers[2])
        lu.assertIsTrue(map.layerpaths['image_layer'] == map.layers[3])
        lu.assertIsTrue(map.layerpaths['group_layer'] == map.layers[4])
        lu.assertIsTrue(map.layerpaths['group_layer.layer.with.dots'] == map.layers[4].layers[1])
        lu.assertIsTrue(map.layerpaths['group_layer.child_tile_layer'] == map.layers[4].layers[2])
        lu.assertIsTrue(map.layerpaths['group_layer.child_object_layer'] == map.layers[4].layers[3])
        lu.assertIsTrue(map.layerpaths['group_layer.child_image_layer'] == map.layers[4].layers[4])
        lu.assertIsTrue(map.layerpaths['group_layer.child_group_layer'] == map.layers[4].layers[5])
    end

    --================
    -- Parallax Origin
    --================

    function TestMapMaticMap:test_mapmatic_map_init__parallax_origin__no_exported_origin()
        local map = MapFactory(parallax_no_origin)
        lu.assertEquals({map.parallaxoriginx, map.parallaxoriginy}, {0, 0})
    end

    function TestMapMaticMap:test_mapmatic_map_init__parallax_origin__with_exported_origin()
        local map = MapFactory(parallax_origin)
        lu.assertEquals({map.parallaxoriginx, map.parallaxoriginy}, {10, 20})
    end

    function TestMapMaticMap:test_mapmatic_map_init__parallax_origin__original_table_removed()
        local map = MapFactory(parallax_origin)
        lu.assertIsNil(map.parallaxorigin)
    end

    -----------------------------------------

    --[[ Map:getFactory ]]

    function TestMapMaticMap:test_mapmatic_map_get_factory()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertIsTrue(map:getFactory() == MapFactory)
    end

    --[[ Map:loadPlugin ]]

    function TestMapMaticMap:test_mapmatic_map_load_plugin()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertNotIsNil(map.__plugins["PluginTemplate"])
    end

    function TestMapMaticMap:test_mapmatic_map_load_plugin__map_parameter()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertIsTrue(map.__plugins["PluginTemplate"].map == map)
    end

    function TestMapMaticMap:test_mapmatic_map_load_plugin__additional_parameters()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertIsTrue(map.__plugins["PluginTemplate"].param1 == "test param1")
        lu.assertIsTrue(map.__plugins["PluginTemplate"].param2 == "test param2")
    end

    function TestMapMaticMap:test_mapmatic_map_load_plugin__plugin_handle_returned()
        local map = MapFactory(empty_10x6_ortho)
        local plugin = map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertIsTrue(map.__plugins["PluginTemplate"] == plugin)
    end

    function TestMapMaticMap:test_mapmatic_map_load_plugin__plugin_already_loaded()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertErrorMsgContains("loadPlugin : plugin has already been loaded for this map : name=PluginTemplate",
            map.loadPlugin, map, "PluginTemplate")
    end

    function TestMapMaticMap:test_mapmatic_map_load_plugin__plugin_unable_to_load()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertErrorMsgContains("loadPlugin : unable to load map plugin : name=NotAPlugin",
            map.loadPlugin, map, "NotAPlugin")
    end

    --[[ Map:plugin ]]

    function TestMapMaticMap:test_mapmatic_map_plugin()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "test param1", "test param2")
        lu.assertIsTrue(map:plugin("PluginTemplate") == map.__plugins["PluginTemplate"])
    end

    function TestMapMaticMap:test_mapmatic_map_plugin__no_plugins_loaded()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertErrorMsgContains("plugin : no plugins have been loaded for this map",
            map.plugin, map, "")
    end

    function TestMapMaticMap:test_mapmatic_map_plugin__plugin_not_found()
        local map = MapFactory(empty_10x6_ortho)
        map:loadPlugin("PluginTemplate", "", "")
        lu.assertErrorMsgContains("plugin : no such plugin has been loaded for this map : name=NotAPlugin",
            map.plugin, map, "NotAPlugin")
    end

    function TestMapMaticMap:test_mapmatic_map_plugin__plugin_name_is_nil()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertErrorMsgContains("plugin : plugin name parameter must be a string value",
            map.plugin, map)
    end

    --[[ Map:getMapName ]]

    function TestMapMaticMap:test_mapmatic_map_get_map_name()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getMapName(), "empty_10x6_ortho")
    end

    --[[ Map:getDirectory ]]

    function TestMapMaticMap:test_mapmatic_map_get_directory()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getDirectory(), mapdir)
    end

    --[[ Map:getFileName ]]

    function TestMapMaticMap:test_mapmatic_map_get_file_name__include_directory()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getFileName(true), mapdir .. "empty_10x6_ortho" .. ".lua")
    end

    function TestMapMaticMap:test_mapmatic_map_get_file_name__do_not_include_directory()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getFileName(false), "empty_10x6_ortho" .. ".lua")
    end

    function TestMapMaticMap:test_mapmatic_map_get_file_name__empty_parameter()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getFileName(), mapdir .. "empty_10x6_ortho" .. ".lua")
    end

    --[[ Map:getTilePosition ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile_position__tile_top_left()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals({map:getTilePosition(0, 0)}, {0, 0})
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_position__tile_bottom_right()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals({map:getTilePosition(7, 7)}, {7 * 16, 7 * 16})
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_position__tile_on_map()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals({map:getTilePosition(3, 2)}, {16 * 3, 16 * 2})
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_position__tile_off_map()
        local map = MapFactory(simple_8x8_ortho_ts1)
        lu.assertEquals({map:getTilePosition(-3, -2)}, {-16 * 3, -16 * 2})
    end

    --[[ Map:getWidth ]]

    function TestMapMaticMap:test_mapmatic_map_get_width()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getWidth(), 10)
    end

    --[[ Map:getHeight ]]

    function TestMapMaticMap:test_mapmatic_map_get_height()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getHeight(), 6)
    end

    --[[ Map:getMapWidth ]]

    function TestMapMaticMap:test_mapmatic_map_get_map_width()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getMapWidth(), 10 * 16)
    end

    --[[ Map:getMapHeight ]]

    function TestMapMaticMap:test_mapmatic_map_get_map_height()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertEquals(map:getMapHeight(), 6 * 16)
    end

    --[[ Map:getTileWidth ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile_width()
        local map = MapFactory(empty_2x2_ortho__tilesize_10x20)
        lu.assertEquals(map:getTileWidth(), 10)
    end

    --[[ Map:getTileHeight ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile_height()
        local map = MapFactory(empty_2x2_ortho__tilesize_10x20)
        lu.assertEquals(map:getTileHeight(), 20)
    end

    --[[ Map:getOrientation ]]

    function TestMapMaticMap:test_mapmatic_map_get_orientation()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(map:getOrientation(), "orthogonal")
    end

    --[[ Map:resize ]]

    function TestMapMaticMap:test_mapmatic_map_resize__no_params()
        local map = MapFactory(empty_8x8_ortho)
        map:resize()
        lu.assertEquals({map.canvas:getDimensions()}, {love.graphics.getWidth(), love.graphics.getHeight()})
    end

    function TestMapMaticMap:test_mapmatic_map_resize__width_height()
        local map = MapFactory(empty_8x8_ortho)
        map:resize(100, 200)
        lu.assertEquals({map.canvas:getDimensions()}, {100, 200})
    end

    function TestMapMaticMap:test_mapmatic_map_resize__canvas_filter()
        local map = MapFactory(empty_8x8_ortho)
        map:resize(100, 200)
        lu.assertEquals({map.canvas:getFilter()}, {'nearest', 'nearest', 1})
    end

    --[[ Map:getCanvas ]]

    function TestMapMaticMap:test_mapmatic_map_get_canvas()
        local map = MapFactory(empty_10x6_ortho)
        lu.assertNotIsNil(map:getCanvas())
        lu.assertEquals(map:getCanvas():type(), "Canvas")
    end

    --[[ Map:getParallaxOrigin ]]

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin__no_origin()
        local map = MapFactory(parallax_no_origin)
        lu.assertEquals({map:getParallaxOrigin()}, {0, 0})
    end

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin__with_origin()
        local map = MapFactory(parallax_origin)
        lu.assertEquals({map:getParallaxOrigin()}, {10, 20})
    end

    --[[ Map:getParallaxOriginX ]]

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin_x__no_origin()
        local map = MapFactory(parallax_no_origin)
        lu.assertEquals(map:getParallaxOriginX(), 0)
    end

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin_x__with_origin()
        local map = MapFactory(parallax_origin)
        lu.assertEquals(map:getParallaxOriginX(), 10)
    end

    --[[ Map:getParallaxOriginY ]]

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin_y__no_origin()
        local map = MapFactory(parallax_no_origin)
        lu.assertEquals(map:getParallaxOriginY(), 0)
    end

    function TestMapMaticMap:test_mapmatic_map_get_parallax_origin_y__with_origin()
        local map = MapFactory(parallax_origin)
        lu.assertEquals(map:getParallaxOriginY(), 20)
    end

    --[[ Map:setParallaxOrigin ]]

    function TestMapMaticMap:test_mapmatic_map_set_parallax_origin()
        local map = MapFactory(parallax_no_origin)
        map:setParallaxOrigin(10, 20)
        lu.assertEquals({map.parallaxoriginx, map.parallaxoriginy}, {10, 20})
    end

    --[[ Map:setParallaxOriginX ]]

    function TestMapMaticMap:test_mapmatic_map_set_parallax_origin_x()
        local map = MapFactory(parallax_no_origin)
        map:setParallaxOriginX(10)
        lu.assertEquals({map.parallaxoriginx, map.parallaxoriginy}, {10, 0})
    end

    function TestMapMaticMap:test_mapmatic_map_set_parallax_origin_x__param_1_not_number()
        local map = MapFactory(parallax_no_origin)
        lu.assertErrorMsgContains("setParallaxOriginX : param #1 must be a number type",
            map.setParallaxOriginX, map, "10")
    end

    --[[ Map:setParallaxOriginY ]]

    function TestMapMaticMap:test_mapmatic_map_set_parallax_origin_y()
        local map = MapFactory(parallax_no_origin)
        map:setParallaxOriginY(20)
        lu.assertEquals({map.parallaxoriginx, map.parallaxoriginy}, {0, 20})
    end

    function TestMapMaticMap:test_mapmatic_map_set_parallax_origin_y__param_1_not_number()
        local map = MapFactory(parallax_no_origin)
        lu.assertErrorMsgContains("setParallaxOriginY : param #1 must be a number type",
            map.setParallaxOriginY, map, "10")
    end

    --[[ Map:getLayer ]]

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_tile_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('tile_layer')
        lu.assertEquals(layer:type(), "TileLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_object_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('object_layer')
        lu.assertEquals(layer:type(), "ObjectLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_image_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('image_layer')
        lu.assertEquals(layer:type(), "ImageLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_group_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('group_layer')
        lu.assertEquals(layer:type(), "GroupLayer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_with_layer_path()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('group_layer.child_tile_layer')
        lu.assertEquals(layer:getName(), "child_tile_layer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__get_by_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer(3)
        lu.assertEquals(layer:getName(), "image_layer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__group_layer__get_by_name()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer('group_layer')
        local layer = map:getLayer("child_object_layer", grouplayer)
        lu.assertEquals(layer:getName(), "child_object_layer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__group_layer__get_by_index()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer('group_layer')
        local layer = map:getLayer(3, grouplayer)
        lu.assertEquals(layer:getName(), "child_object_layer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__group_layer__get_by_layerpath()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer('group_layer')
        local layer = map:getLayer("child_group_layer.sub_layer", grouplayer)
        lu.assertEquals(layer:getName(), "sub_layer")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__param1_not_string_or_number()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertErrorMsgContains('getLayer : layerid must be either a string path or a number index : id=true',
            map.getLayer, map, true)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__param2_not_layer()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertErrorMsgContains('getLayer : parameter #2 is not a valid group layer',
            map.getLayer, map, 1, {})
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__param2_not_group_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer('tile_layer')
        lu.assertErrorMsgContains('getLayer : parameter #2 is not a valid group layer',
            map.getLayer, map, 1, layer)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer__layer_does_not_exist()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertErrorMsgContains('getLayer : layer does not exist in the lookup table : id=999',
            map.getLayer, map, 999)
    end

    --[[ Map:getLayers ]]

    function TestMapMaticMap:test_mapmatic_map_get_layers()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertEquals(#map:getLayers(), 11)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__order()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers()
        lu.assertEquals(list[1]:getName(), "tile_layer")
        lu.assertEquals(list[2]:getName(), "object_layer")
        lu.assertEquals(list[3]:getName(), "image_layer")
        lu.assertEquals(list[4]:getName(), "group_layer")
        lu.assertEquals(list[5]:getName(), "layer.with.dots")
        lu.assertEquals(list[6]:getName(), "child_tile_layer")
        lu.assertEquals(list[7]:getName(), "child_object_layer")
        lu.assertEquals(list[8]:getName(), "child_image_layer")
        lu.assertEquals(list[9]:getName(), "child_group_layer")
        lu.assertEquals(list[10]:getName(), "sub_layer")
        lu.assertEquals(list[11]:getName(), "empty_group")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__tile_layer()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertNotIsNil(list.tilelayers)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__tile_layer__number()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertEquals(#list.tilelayers, 4)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__tile_layer__order()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)

        local group1 = map:getLayer("group_layer")
        local group2 = map:getLayer("child_group_layer", group1)

        lu.assertEquals(list.tilelayers, {
            map:getLayer("tile_layer"),
            map:getLayer("layer.with.dots", group1),
            map:getLayer("child_tile_layer", group1),
            map:getLayer("sub_layer", group2),
        })
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__object_layer()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertNotIsNil(list.objectgroups)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__object_layer__number()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertEquals(#list.objectgroups, 2)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__object_layer__order()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)

        local group1 = map:getLayer("group_layer")

        lu.assertEquals(list.objectgroups, {
            map:getLayer("object_layer"),
            map:getLayer("child_object_layer", group1),
        })
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__image_layer()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertNotIsNil(list.imagelayers)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__image_layer__number()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertEquals(#list.imagelayers, 2)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__image_layer__order()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)

        local group1 = map:getLayer("group_layer")

        lu.assertEquals(list.imagelayers, {
            map:getLayer("image_layer"),
            map:getLayer("child_image_layer", group1),
        })
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__group_layer()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertNotIsNil(list.groups)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__group_layer__number()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)
        lu.assertEquals(#list.groups, 2)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__group_layer__order()
        local map = MapFactory(layers_8x8_ortho)
        local list = map:getLayers(true)

        local group = map:getLayer("group_layer")

        lu.assertEquals(list.groups, {
            group,
            map:getLayer("child_group_layer", group),
        })
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__custom_layer()
        local map = MapFactory(layers_8x8_ortho)
        local plugin = map:loadPlugin("ModifyMap")

        local group = map:getLayer("group_layer")
        plugin:addCustomLayer("custom_layer_1")
        plugin:addCustomLayer("custom_layer_1", 1, group)

        local list = map:getLayers(true)
        lu.assertNotIsNil(list.customs)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__group_layer__number()
        local map = MapFactory(layers_8x8_ortho)
        local plugin = map:loadPlugin("ModifyMap")

        local group = map:getLayer("group_layer")
        plugin:addCustomLayer("custom_layer_1")
        plugin:addCustomLayer("custom_layer_2", 1, group)

        local list = map:getLayers(true)
        lu.assertEquals(#list.customs, 2)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layers__grouped__group_layer__order()
        local map = MapFactory(layers_8x8_ortho)
        local plugin = map:loadPlugin("ModifyMap")

        local group = map:getLayer("group_layer")
        local layer1 = plugin:addCustomLayer("custom_layer_1", 1)
        local layer2 = plugin:addCustomLayer("custom_layer_2", 1, group)

        local list = map:getLayers(true)

        lu.assertEquals(list.customs, {layer1, layer2})
    end

    --[[ Map:hasLayer ]]

    function TestMapMaticMap:test_mapmatic_map_has_layer__true()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertIsTrue(map:hasLayer("tile_layer"))
    end

    function TestMapMaticMap:test_mapmatic_map_has_layer__true__exists_with_group()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer("group_layer")
        lu.assertIsTrue(map:hasLayer("child_tile_layer", grouplayer))
    end

    function TestMapMaticMap:test_mapmatic_map_has_layer__false()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertIsFalse(map:hasLayer("not_a_layer"))
    end

    function TestMapMaticMap:test_mapmatic_map_has_layer__false__exists_but_not_in_group()
        local map = MapFactory(layers_8x8_ortho)
        lu.assertIsFalse(map:hasLayer("child_tile_layer"))
    end

    --[[ Map:getTileSet ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile_set__by_id()
        local map = MapFactory(simple_8x8_ortho_ts1_tc1)
        local ts = map:getTileSet(1)
        lu.assertEquals(ts:type(), "TileSet")
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_set__by_name()
        local map = MapFactory(simple_8x8_ortho_ts1_tc1)
        local ts = map:getTileSet("world_tileset")
        lu.assertEquals(ts:type(), "TileSet")
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_set__tileset_not_found()
        local map = MapFactory(simple_8x8_ortho_ts1_tc1)
        local ts = map:getTileSet(999)
        lu.assertIsNil(ts)
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_set__param1_not_number_or_string()
        local map = MapFactory(simple_8x8_ortho_ts1_tc1)
        lu.assertErrorMsgContains('getTileSet : invalid tileset identifier passed into method : id=true',
            map.getTileSet, map, true)
    end

    --[[ Map:getTile ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile()
        local map = MapFactory(simple_8x8_ortho_ts1)
        local tile = map:getTile(1)
        lu.assertEquals(tile:type(), "Tile")
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile__tile_not_found()
        local map = MapFactory(simple_8x8_ortho_ts1)
        local tile = map:getTile(999)
        lu.assertIsNil(tile)
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile__nil_guard()
        local map = MapFactory(simple_8x8_ortho_ts1)
        local tile = map:getTile()
        lu.assertIsNil(tile)
    end

    --[[ Map:getLayerObject ]]

    function TestMapMaticMap:test_mapmatic_map_get_layer_object__by_id()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        local layer = map:getLayer("object_layer1")
        local object = map:getLayerObject(layer.objects[1].id)
        lu.assertEquals(object:type(), "MapObject")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer_object__by_name()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        local object = map:getLayerObject("rectangle_object")
        lu.assertEquals(object:type(), "MapObject")
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer_object__not_found()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        local object = map:getLayerObject(999)
        lu.assertIsNil(object)
    end

    function TestMapMaticMap:test_mapmatic_map_get_layer_object__param1_not_number_or_string()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        lu.assertErrorMsgContains('getLayerObject : invalid layer object identifier passed into method : id=true',
            map.getLayerObject, map, true)
    end

    --[[ Map:getTileObject ]]

    function TestMapMaticMap:test_mapmatic_map_get_tile_object__by_id()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        local ts = map:getTileSet(1)
        local object = map:getTileObject(ts.tiles[1].gid)
        lu.assertEquals(object:type(), "MapObject")
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_object__by_name()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        local object = map:getTileObject("tile_object")
        lu.assertEquals(object:type(), "MapObject")
    end

    function TestMapMaticMap:test_mapmatic_map_get_tile_object__param1_not_number_or_string()
        local map = MapFactory(layer_8x8_ortho_ts1_anim)
        lu.assertErrorMsgContains('getTileObject : invalid layer object identifier passed into method : id=true',
            map.getTileObject, map, true)
    end







































