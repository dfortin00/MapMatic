
local mapdir             = 'assets/maps/orthogonal/'

local simple_8x8         = mapdir .. 'simple_8x8_ortho_tc1'
local encoded_gzip       = mapdir .. 'encoded_gzip_4x5'
local encoded_zlib       = mapdir .. 'encoded_zlib_4x5'
local encoded_base64     = mapdir .. 'encoded_base64_4x5'
local duplicate_layers   = mapdir .. 'duplicate_layers_1x1_ortho'
local layers_8x8_ortho   = mapdir .. 'layers_8x8_ortho'

TestMapMaticLayer = {}

    function TestMapMaticLayer:tearDown()
        MapFactory:clearCache()
    end

    -- NOTE: There is no way to retrieve a Layer object directly through MapMatic code unless there is
    --       an unknown layer type in the map (unlikely to happen). The following tests will test the
    --       Layer class indirectly by first retrieving other layer class objects.

    function TestMapMaticLayer:test_mapmatic_layer__class_name()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer("group_layer")
        local layer = grouplayer.__includes
        lu.assertEquals(layer:type(), "Layer")
    end

    function TestMapMaticLayer:test_mapmatic_layer__type_of()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer("group_layer")
        local layer = grouplayer.__includes
        lu.assertIsTrue(layer:typeOf("TObject"))
    end

    --[[ Layer:init ]]

    function TestMapMaticLayer:test_mapmatic_layer_init__map()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer.map == map)
    end

    --=======
    -- Parent
    --=======

    function TestMapMaticLayer:test_mapmatic_layer_init__root_parent()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsNil(layer.parent)
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__group_parent()
        local map = MapFactory(layers_8x8_ortho)
        local grouplayer = map:getLayer("group_layer")
        local sublayer = map:getLayer("group_layer.child_group_layer")
        lu.assertIsTrue(sublayer.parent == grouplayer)
    end

    --===========
    -- Properties
    --===========

    function TestMapMaticLayer:test_mapmatic_layer_init__properties__root_level__no_layer_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        lu.assertEquals(layer.properties:getNumProperties(), 2)
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__properties__root_level__with_layer_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        lu.assertEquals(layer.properties:getNumProperties(), 2)
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
        lu.assertEquals(layer:getProperty("custom_group_property"), "test group string")
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__properties__group_level()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")

        lu.assertEquals(layer:getNumProperties(), 3)
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
        lu.assertEquals(layer:getProperty("custom_group_property"), "test group string")
        lu.assertEquals(layer:getProperty("custom_child_property"), "test child string")
    end

    --============
    -- Layer Paths
    --============

    function TestMapMaticLayer:test_mapmatic_layer_init__layerpath__root_level()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer.layerpath, "group_layer")
        lu.assertNotIsNil(map.layerpaths["group_layer"])
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__layerpath__group_level()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer.sub_layer")
        lu.assertEquals(layer.layerpath, "group_layer.child_group_layer.sub_layer")
        lu.assertNotIsNil(map.layerpaths["group_layer.child_group_layer.sub_layer"])
    end

    -- Note: Using dots in the layer name is not prevented by the code, but should be discouraged.
    --    This test is to ensure nothing breaks if a layer name does contain dots.
    function TestMapMaticLayer:test_mapmatic_layer_init__layerpath__layer_names_can_have_dots()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.layer.with.dots")
        lu.assertEquals(layer.layerpath, "group_layer.layer.with.dots")
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__layerpath__no_duplicates_layer_names_allowed()
        lu.assertErrorMsgContains("init : duplicate layer paths are not supported : path=tile_layer",
            MapFactory.__call, MapFactory, duplicate_layers
        )
    end

    --============
    -- Layer Index
    --============

    function TestMapMaticLayer:test_mapmatic_layer_init__layerindex__root_level()
        local map = MapFactory(layers_8x8_ortho)

        lu.assertEquals(map:getLayer("tile_layer").layerindex, 1)
        lu.assertEquals(map:getLayer("object_layer").layerindex, 2)
        lu.assertEquals(map:getLayer("image_layer").layerindex, 3)
        lu.assertEquals(map:getLayer("group_layer").layerindex, 4)
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__layerindex__group_level()
        local map = MapFactory(layers_8x8_ortho)

        local groupindex = map:getLayer("group_layer").layerindex

        lu.assertEquals(map:getLayer("group_layer.layer.with.dots").layerindex   , groupindex + 1)
        lu.assertEquals(map:getLayer("group_layer.child_tile_layer").layerindex  , groupindex + 2)
        lu.assertEquals(map:getLayer("group_layer.child_object_layer").layerindex, groupindex + 3)
        lu.assertEquals(map:getLayer("group_layer.child_image_layer").layerindex , groupindex + 4)
        lu.assertEquals(map:getLayer("group_layer.child_group_layer").layerindex , groupindex + 5)
    end

    --==============
    -- Data Encoding
    --==============

    local function _check_map_decoding(map)
        local layer = map:getLayer(1)
        lu.assertIsTable(layer.data)
        lu.assertEquals(#layer.data, 5)
        for i = 1, #layer.data do
            lu.assertEquals(#layer.data[i], 4)
            for j = 1, #layer.data[i] do
                lu.assertEquals(layer.data[i][j].tile.gid, i)
            end
        end
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__encoding__base64_uncompressed()
        local map = MapFactory(encoded_base64)
        _check_map_decoding(map)
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__encoding__gzip_compression()
        local map = MapFactory(encoded_gzip)
        _check_map_decoding(map)
    end

    function TestMapMaticLayer:test_mapmatic_layer_init__encoding__zlib_compression()
        local map = MapFactory(encoded_zlib)
        _check_map_decoding(map)
    end

    --==============
    -- Layer Offsets
    --==============

    function TestMapMaticLayer:test_mapmatic_layer_init__offsets()
        local map = MapFactory(layers_8x8_ortho, {offsetx=60, offsety=70})
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer.offsetx, layer.offsety}, {10, 20})
    end

    ---------------------














