
local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho = mapdir .. 'batch_8x8_ortho__ts1_tc1'

TestMapMaticTObject = {}

    function TestMapMaticTObject:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticTObject:test_mapmatic_tobject__type()
        local map = MapFactory(batch_8x8_ortho)
        local tobject = map.__includes
        lu.assertEquals(tobject:type(), "TObject")
    end

    -- Note: Only test parameter types validations for TObject class. Other functionality will be tested
    --       in the test suites for the inherited child classes such as the map, layers, tiles, etc...

    --[[ TObject:setName ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_name__param1_not_string()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setName : param #1 must be a string type", layer.setName, layer, 0)
    end

    --[[ TObject:setPosition ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_position__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setPosition : param #1 must be a number type", layer.setPosition, layer, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_position__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setPosition : param #2 must be a number type", layer.setPosition, layer, 0, "")
    end

    --[[ TObject:setX ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_x__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setX : param #1 must be a number type", layer.setX, layer, "")
    end

    --[[ TObject:setY ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_y__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setY : param #1 must be a number type", layer.setY, layer, "")
    end

    --[[ TObject:moveBy ]]

    function TestMapMaticTObject:test_mapmatic_tobject_move_by__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("moveBy : param #1 must be a number type", layer.moveBy, layer, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_move_by__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("moveBy : param #2 must be a number type", layer.moveBy, layer, 0, "")
    end

    --[[ TObject:setRotation ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_rotation__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setRotation : param #1 must be a number type", instance.setRotation, instance, "")
    end

    --[[ TObject:rotateBy ]]

    function TestMapMaticTObject:test_mapmatic_tobject_rotate_by__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("rotateBy : param #1 must be a number type", instance.rotateBy, instance, "")
    end

    --[[ TObject:setScale ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_scale__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setScale : param #1 must be a number type", instance.setScale, instance, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_scale__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setScale : param #2 must be a number type", instance.setScale, instance, 0, "")
    end

    --[[ TObject:setScaleX ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_scale_x__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setScaleX : param #1 must be a number type", instance.setScaleX, instance, "")
    end

    --[[ TObject:setScaleY ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_scale_y__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setScaleY : param #1 must be a number type", instance.setScaleY, instance, "")
    end

    --[[ TObject:scaleBy ]]

    function TestMapMaticTObject:test_mapmatic_tobject_scale_by__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("scaleBy : param #1 must be a number type", instance.scaleBy, instance, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_scale_by__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("scaleBy : param #2 must be a number type", instance.scaleBy, instance, 0, "")
    end

    --[[ TObject:setOrigin ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_origin__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setOrigin : param #1 must be a number type", instance.setOrigin, instance, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_origin__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setOrigin : param #2 must be a number type", instance.setOrigin, instance, 0, "")
    end

    --[[ TObject:setOriginX ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_origin_x__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setOriginX : param #1 must be a number type", instance.setOriginX, instance, "")
    end

    --[[ TObject:setOriginY ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_origin_y__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local instance = map:getLayer("ts_layer__fit"):getTileInstance(1, 5)
        lu.assertErrorMsgContains("setOriginY : param #1 must be a number type", instance.setOriginY, instance, "")
    end

    --[[ TOBject:setOffsets ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_offsets__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        lu.assertErrorMsgContains("setOffsets : param #1 must be a number type", map.setOffsets, map, "")
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_offsets__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        lu.assertErrorMsgContains("setOffsets : param #2 must be a number type", map.setOffsets, map, 0, "")
    end

    --[[ TOBject:setOffsetX ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_offset_x__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        lu.assertErrorMsgContains("setOffsetX : param #1 must be a number type", map.setOffsetX, map, "")
    end

    --[[ TOBject:setOffsetY ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_offset_y__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        lu.assertErrorMsgContains("setOffsetY : param #1 must be a number type", map.setOffsetY, map, "")
    end

    --[[ TObject:setVisibility ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_visibility__nil()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        layer:setVisibility()
        lu.assertIsTrue(layer.visible)
    end

    --[[ TObject:setOpacity ]]

    function TestMapMaticTObject:test_mapmatic_tobject_set_opacity__less_than_zero()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        layer:setOpacity(-1)
        lu.assertEquals(layer.opacity, 0)
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_opacity__greater_than_one()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        layer:setOpacity(1.1)
        lu.assertEquals(layer.opacity, 1)
    end

    function TestMapMaticTObject:test_mapmatic_tobject_set_opacity__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        lu.assertErrorMsgContains("setOpacity : param #1 must be a number type", layer.setOpacity, layer, "")
    end









































