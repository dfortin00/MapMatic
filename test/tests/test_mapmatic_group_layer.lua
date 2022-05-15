
local mapdir = 'assets/maps/orthogonal/'

local layers_8x8_ortho     = mapdir .. 'layers_8x8_ortho'
local simple_8x8_ortho_tc1 = mapdir .. 'simple_8x8_ortho_tc1'

TestMapMaticGroupLayer = {}

    function TestMapMaticGroupLayer:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__class_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:type(), "GroupLayer")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__type_of()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:typeOf("Layer"))
    end

    --[[ GroupLayer:init ]]

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_init__layers__number_children()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(#layer.layers, 5)
    end

    --[[ GroupLayer:getNumChildren ]]

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_get_num_children__existing_layer()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getNumChildren(), 5)
    end

    --[[ GroupLayer:getChildLayer ]]

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_get_child_layer__by_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        local child = layer:getChildLayer(1)

        lu.assertEquals(child.name, "layer.with.dots")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_get_child_layer__by_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        local child = layer:getChildLayer("child_object_layer")

        lu.assertEquals(child.name, "child_object_layer")
    end

    --[[ GroupLayer:hasLayer ]]

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_has_layer__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:hasLayer("child_tile_layer"))
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer_has_layer__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsFalse(layer:hasLayer("not a layer"))
    end

    --============================
    -- Layer
    --============================

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_map()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:getMap() == map)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_child__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertIsTrue(layer:isChild())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_child__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsFalse(layer:isChild())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__has_parent__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertIsTrue(layer:hasParent())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__has_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsFalse(layer:hasParent())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_parent__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:isParent())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("empty_group")
        lu.assertIsFalse(layer:isParent())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__has_children__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:hasChildren())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__has_children__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("empty_group")
        lu.assertIsFalse(layer:hasChildren())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_parent()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertIsTrue(layer:getParent() == map:getLayer("group_layer"))
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_layer_type()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getLayerType(), "group")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_layer_path()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertEquals(layer:getLayerPath(), "group_layer.child_group_layer")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getIndex(), 4)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_group_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getGroupIndex(), 4)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_group_index__child()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertEquals(layer:getGroupIndex(), 5)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertEquals({layer:getParallax()}, {8, 15})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertEquals(layer:getParallaxX(), 8)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertEquals(layer:getParallaxY(), 15)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__set_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")

        layer:setParallax(0.5, 2)

        -- parent: 2, 3 ; layer: 0.5, 2
        lu.assertEquals({layer:getParallax()}, {1, 6})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__set_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")

        layer:setParallaxX(0.5)

        -- parent: 2, 3 ; layer: 0.5, 5
        lu.assertEquals({layer:getParallax()}, {1, 15})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__set_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")

        layer:setParallaxY(2)

        -- parent: 2, 3 ; layer: 4, 2
        lu.assertEquals({layer:getParallax()}, {8, 6})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_visible__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_visible__false()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_visible__parent_visible()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_group_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__is_visible__parent_not_visible()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_group_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getOffsetX(), 10)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getOffsetY(), 20)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__layer__get_opacity()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_group_layer")
        lu.assertAlmostEquals(layer:getOpacity(), 0.04, 0.00001)
    end

    --============================
    -- TObject
    --============================

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_id()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getId(), 2)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getName(), "group_layer")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setName("new_layer_name")

        lu.assertEquals(layer:getName(), "new_layer_name")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getX(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getY(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setPosition(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setX(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setY(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__move_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:moveBy(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setRotation(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__rotate_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:rotateBy(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getScaleX(), 1)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getScaleY(), 1)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setScale(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setScaleX(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setScaleY(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__scale_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:scaleBy(3, 5)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getOriginX(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getOriginY(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOrigin(10, 20)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOriginX(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOriginY(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__draw_coords()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getDrawCoords()}, {10, 20, 0, 1, 1, 0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_dimensions()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getDimensions()}, {0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_width()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getWidth(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_height()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getHeight(), 0)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_rect()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getRect()}, {0, 0, 0, 0})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals({layer:getOffsets()}, {10, 20})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOffsets(40, 50)

        lu.assertEquals({layer:getOffsets()}, {40, 50})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOffsetX(40)

        lu.assertEquals({layer:getOffsets()}, {40, 20})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOffsetY(40)

        lu.assertEquals({layer:getOffsets()}, {10, 40})
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_visibility__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setVisibility(true)

        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_visibility__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setVisibility(false)

        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_opacity()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setOpacity(0.1)

        lu.assertEquals(layer.opacity, 0.1)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__get_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getProperty("custom_group_property"), "test group string")
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")

        layer:setProperty("additional_property", "additional property string")

        lu.assertEquals(layer:getProperty("additional_property"), "additional property string")
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__set_num_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertEquals(layer:getNumProperties(), 2)
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__has_property_key__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsTrue(layer:hasPropertyKey("custom_group_property"))
        lu.assertIsTrue(layer:hasPropertyKey("custom_map_property"))
    end

    function TestMapMaticGroupLayer:test_mapmatic_group_layer__tobject__has_property_key__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer")
        lu.assertIsFalse(layer:hasPropertyKey("not_a_property"))
    end



























