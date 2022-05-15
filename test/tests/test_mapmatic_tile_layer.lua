
local mapdir = 'assets/maps/orthogonal/'

local infinite_ortho       = mapdir .. 'infinite_ortho__ts1_tc1'
local batch_8x8_ortho      = mapdir .. 'batch_8x8_ortho__ts1_tc1'
local layers_8x8_ortho     = mapdir .. 'layers_8x8_ortho'
local infinite_ortho_empty = mapdir .. 'infinite_empty_ortho'
local simple_8x8_ortho_tc1 = mapdir .. 'simple_8x8_ortho_tc1'

TestMapMaticTileLayer = {}

    function TestMapMaticTileLayer:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__class_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:type(), "TileLayer")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__type_of()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsTrue(layer:typeOf("Layer"))
    end

    --[[ TileLayer:init ]]

    --==========
    -- Tile Data
    --==========

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__tile_instance__layer()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals(layer.data[1][1]:type(), "TileInstance")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__tile_instance__layer_gid()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals(layer.data[1][1].tile.gid, 24)
        lu.assertEquals(layer.data[3][2].tile.gid, 33)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__tile_instance__chunks()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer.chunks[1].data[2][3]:type(), "TileInstance")
        lu.assertEquals(layer.chunks[2].data[2][1]:type(), "TileInstance")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__tile_instance__chunk_gid()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer.chunks[1].data[2][3].tile.gid, 24)
        lu.assertEquals(layer.chunks[1].data[5][5].tile.gid, 33)
    end

    --===============
    -- Sprite Batches
    --===============

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__layer__tilesets()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals(layer.batches[1]:type(), "SpriteBatch")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__layer__tilecollections()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        lu.assertEquals(layer.batches[2][0]:type(), "SpriteBatch")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__layer__batch_id()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        -- Make sure batchid exists and is populated with value.
        lu.assertEquals(layer.data[1][1].batchid, 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__layer__no_batch_draw()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertIsNil(layer.batches)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__chunks__tilesets()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer.chunks[1].batches[1]:type(), "SpriteBatch")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__chunks__tilecollections()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tc_tile_layer")
        lu.assertEquals(layer.chunks[1].batches[2][0]:type(), "SpriteBatch")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__chunks__batch_id()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        -- Make sure batchid exists and is populated with value.
        lu.assertEquals(layer.chunks[1].data[2][3].batchid, 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__sprite_batches__chunks__no_batch_draw()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tc_tile_layer__does_not_fit")
        lu.assertIsNil(layer.chunks[1].batches)
    end

    --===============
    -- Use Batch Draw
    --===============

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__tileset__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertIsTrue(layer.usebatchdraw)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__tileset__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertIsFalse(layer.usebatchdraw)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__tilecollection__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        lu.assertIsTrue(layer.usebatchdraw)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__tilecollection__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        lu.assertIsFalse(layer.usebatchdraw)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__when_true_renderer_not_used()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertIsNil(layer.renderer)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_init__batch_draw__when_false_renderer_used()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertNotIsNil(layer.renderer)
        lu.assertEquals(layer.renderer:type(), "LayerRenderer")
    end

    -----------------------------------

    --[[ TileLayer:usesBatchDraw ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_is_batch_draw__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertIsTrue(layer:usesBatchDraw())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_is_batch_draw__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertIsFalse(layer:usesBatchDraw())
    end

    --[[ TileLayer:setBatchDraw ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_set_batch_draw__turn_on()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")

        layer:setBatchDraw(true)

        lu.assertNotIsNil(layer.batches)
        lu.assertIsTrue(layer.usebatchdraw)
        lu.assertIsTrue(layer.renderer == nil)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_set_batch_draw__turn_off()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")

        layer:setBatchDraw(false)

        lu.assertIsNil(layer.batches)
        lu.assertIsFalse(layer.usebatchdraw)
        lu.assertIsFalse(layer.renderer == nil)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_set_batch_draw__chunks__turn_on()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tc_tile_layer__does_not_fit")

        layer:setBatchDraw(true)

        lu.assertNotIsNil(layer.chunks[1].batches)
        lu.assertIsTrue(layer.usebatchdraw)
        lu.assertIsTrue(layer.renderer == nil)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_set_batch_draw__chunks__turn_off()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setBatchDraw(false)

        lu.assertIsNil(layer.chunks[1].batches)
        lu.assertIsFalse(layer.usebatchdraw)
        lu.assertIsFalse(layer.renderer == nil)
    end

    --[[ TileLayer:getRenderer ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_renderer__does_not_use_batch_draw()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertEquals(layer:getRenderer():type(), "LayerRenderer")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_renderer__uses_batch_draw()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertIsNil(layer:getRenderer())
    end

    --[[ TileLayer:getTileInstance ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__layer__tile_exists()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(3, 2)
        lu.assertEquals(instance:type(), "TileInstance")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__layer__tile_does_not_exist()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_anim__fit")
        local instance = layer:getTileInstance(3, 2)
        lu.assertIsNil(instance)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__chunks__tile_exists()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        local instance = layer:getTileInstance(-30, -15)
        lu.assertEquals(instance:type(), "TileInstance")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__chunks__tile_does_not_exist()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")

        local instance = layer:getTileInstance(-31, -16)
        lu.assertIsNil(instance)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__chunks__find_instance_across_chunks()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")

        local instance = layer:getTileInstance(-4, -6)
        lu.assertEquals(instance.tile.gid, 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__param1_missing()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertErrorMsgContains("getTileInstance : must include both col and row parameters to locate instance",
            layer.getTileInstance, layer)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instance__param2_missing()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertErrorMsgContains("getTileInstance : must include both col and row parameters to locate instance",
            layer.getTileInstance, layer, 1)
    end

    --[[ TileLayer:getTileInstances ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instances__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instances = layer:getTileInstances()

        lu.assertEquals(#instances, 64)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instances__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instances = layer:getTileInstances()

        lu.assertEquals(#instances, 64)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_tile_instances__gaps()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_anim__fit")
        local instances = layer:getTileInstances()

        lu.assertEquals(#instances, 1)
    end

    --[[ TileLayer:getDimensions ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_dimensions__layer_dimensions_equal_map_dimensions()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals({layer:getDimensions()}, {map.width, map.height})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_dimensions__chunks_dimensions()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getDimensions()}, {64, 48})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_dimensions__chunks_empty()
        local map = MapFactory(infinite_ortho_empty)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getDimensions()}, {0, 0})
    end

    --[[ TileLayer:getWidth ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_width__layer_width_equal_map_width()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals(layer:getWidth(), map.width)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_width__chunks_width()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getWidth(), 64)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_width__chunks_empty()
        local map = MapFactory(infinite_ortho_empty)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getWidth(), 0)
    end

    --[[ TileLayer:getHeight ]]

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_height__layer_width_equal_map_width()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertEquals(layer:getHeight(), map.height)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_height__chunks_height()
        local map = MapFactory(infinite_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getHeight(), 48)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer_get_height__chunks_empty()
        local map = MapFactory(infinite_ortho_empty)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getHeight(), 0)
    end

    --============================
    -- Layer
    --============================

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_map()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsTrue(layer:getMap() == map)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_child__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertIsTrue(layer:isChild())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_child__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:isChild())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__has_parent__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertIsTrue(layer:hasParent())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__has_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:hasParent())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:isParent())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__has_children__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:hasChildren())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_parent()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertIsTrue(layer:getParent() == map:getLayer("group_layer"))
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_layer_type()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getLayerType(), "tilelayer")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_layer_path()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertEquals(layer:getLayerPath(), "group_layer.child_tile_layer")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getIndex(), 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_group_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getGroupIndex(), 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_group_index__child()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertEquals(layer:getGroupIndex(), 2)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertEquals({layer:getParallax()}, {8, 15})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertEquals(layer:getParallaxX(), 8)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertEquals(layer:getParallaxY(), 15)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__set_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")

        layer:setParallax(0.5, 2)

        -- parent: 2, 3 ; layer: 0.5, 2
        lu.assertEquals({layer:getParallax()}, {1, 6})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__set_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")

        layer:setParallaxX(0.5)

        -- parent: 2, 3 ; layer: 0.5, 5
        lu.assertEquals({layer:getParallax()}, {1, 15})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__set_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")

        layer:setParallaxY(2)

        -- parent: 2, 3 ; layer: 4, 2
        lu.assertEquals({layer:getParallax()}, {8, 6})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_visible__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_visible__false()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_visible__parent_visible()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_tile_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__is_visible__parent_not_visible()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_tile_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getOffsetX(), 10)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getOffsetY(), 20)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__layer__get_opacity()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_tile_layer")
        lu.assertAlmostEquals(layer:getOpacity(), 0.04, 0.00001)
    end

    --============================
    -- TObject
    --============================

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_id()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getId(), 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getName(), "tile_layer")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setName("new_layer_name")

        lu.assertEquals(layer:getName(), "new_layer_name")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getX(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getY(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setPosition(10, 20)

        lu.assertEquals({layer:getPosition()}, {10, 20})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setX(10)

        lu.assertEquals({layer:getPosition()}, {10, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setY(10)

        lu.assertEquals({layer:getPosition()}, {0, 10})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__move_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setPosition(10, 20)
        layer:moveBy(30, 50)

        lu.assertEquals({layer:getPosition()}, {40, 70})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setRotation(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__rotate_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:rotateBy(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getScaleX(), 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getScaleY(), 1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setScale(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setScaleX(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setScaleY(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__scale_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:scaleBy(3, 5)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getOriginX(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getOriginY(), 0)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOrigin(10, 20)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOriginX(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOriginY(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__draw_coords()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getDrawCoords()}, {10, 20, 0, 1, 1, 0, 0})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_rect()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getRect()}, {0, 0, 8, 8})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals({layer:getOffsets()}, {10, 20})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOffsets(40, 50)

        lu.assertEquals({layer:getOffsets()}, {40, 50})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOffsetX(40)

        lu.assertEquals({layer:getOffsets()}, {40, 20})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOffsetY(40)

        lu.assertEquals({layer:getOffsets()}, {10, 40})
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_visibility__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setVisibility(true)

        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_visibility__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setVisibility(false)

        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_opacity()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setOpacity(0.1)

        lu.assertEquals(layer.opacity, 0.1)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__get_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getProperty("custom_tilelayer_property"), "test tilelayer string")
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")

        layer:setProperty("additional_property", "additional property string")

        lu.assertEquals(layer:getProperty("additional_property"), "additional property string")
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__set_num_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertEquals(layer:getNumProperties(), 2)
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__has_property_key__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsTrue(layer:hasPropertyKey("custom_tilelayer_property"))
        lu.assertIsTrue(layer:hasPropertyKey("custom_map_property"))
    end

    function TestMapMaticTileLayer:test_mapmatic_tile_layer__tobject__has_property_key__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("tile_layer")
        lu.assertIsFalse(layer:hasPropertyKey("not_a_property"))
    end
























