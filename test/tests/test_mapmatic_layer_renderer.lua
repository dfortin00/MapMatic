
local mapdir = 'assets/maps/orthogonal/'

-- Map variables
local batch_8x8_ortho   = mapdir .. 'batch_8x8_ortho__ts1_tc1'
local render_right_down = mapdir .. 'renderorder_rd_10x10_ortho_ts2_tc1'
local render_right_up   = mapdir .. 'renderorder_ru_10x10_ortho_ts2_tc1'
local render_left_down  = mapdir .. 'renderorder_ld_10x10_ortho_ts2_tc1'
local render_left_up    = mapdir .. 'renderorder_lu_10x10_ortho_ts2_tc1'

TestMapMaticLayerRenderer = {}

    function TestMapMaticLayerRenderer:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        lu.assertEquals(layer:getRenderer():type(), "LayerRenderer")
    end

    --[[ LayerRenderer:init ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__owner()
        local map = MapFactory(render_right_down)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        lu.assertIsTrue(renderer.owner == layer)
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__buffer_width()
        local map = MapFactory(render_right_down)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        lu.assertEquals(renderer.bufferwidth, map:getTileWidth())
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__buffer_height()
        local map = MapFactory(render_right_down)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        lu.assertEquals(renderer.bufferheight, map:getTileHeight())
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__right_down()
        local map = MapFactory(render_right_down)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        local instance = renderer.drawtiles[1]

        lu.assertEquals(instance.tile.gid, 65)
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__right_up()
        local map = MapFactory(render_right_up)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        local instance = renderer.drawtiles[1]

        lu.assertEquals(instance.tile.gid, 84)
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__left_down()
        local map = MapFactory(render_left_down)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        local instance = renderer.drawtiles[1]

        lu.assertEquals(instance.tile.gid, 79)
    end

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_init__left_up()
        local map = MapFactory(render_left_up)
        local layer = map:getLayer("tile_layer")
        local renderer = layer:getRenderer()
        local instance = renderer.drawtiles[1]

        lu.assertEquals(instance.tile.gid, 112)
    end

    -----------------------

    --[[ LayerRenderer:getOwner ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_get_map()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()
        lu.assertIsTrue(renderer:getOwner() == layer)
    end

    --[[ LayerRenderer:getBufferDimensions ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_get_buffer_dimensions()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()
        lu.assertEquals({renderer:getBufferDimensions()}, {map:getTileWidth(), map:getTileHeight()})
    end

    --[[ LayerRenderer:getBufferWidth ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_get_buffer_width()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()
        lu.assertEquals(renderer:getBufferWidth(), map:getTileWidth())
    end

    --[[ LayerRenderer:getBufferHeight ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_get_buffer_height()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()
        lu.assertEquals(renderer:getBufferHeight(), map:getTileHeight())
    end

    --[[ LayerRenderer:setBufferDimensions ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_set_buffer_dimensions()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()

        renderer:setBufferDimensions(10, 20)

        lu.assertEquals({renderer:getBufferDimensions()}, {10, 20})
    end

    --[[ LayerRenderer:setBufferWidth ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_set_buffer_width()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()

        renderer:setBufferWidth(10)

        lu.assertEquals({renderer:getBufferDimensions()}, {10, map:getTileHeight()})
    end

    --[[ LayerRenderer:setBufferHeight ]]

    function TestMapMaticLayerRenderer:test_mapmatic_layer_renderer_set_buffer_height()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local renderer = layer:getRenderer()

        renderer:setBufferHeight(20)

        lu.assertEquals({renderer:getBufferDimensions()}, {map:getTileWidth(), 20})
    end





























