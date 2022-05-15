
local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho      = mapdir .. 'layer_8x8_ortho_ts1_anim'
local object_10x10         = mapdir .. 'object_10x10_ts1'
local layers_8x8_ortho     = mapdir .. 'layers_8x8_ortho'
local simple_8x8_ortho_tc1 = mapdir .. 'simple_8x8_ortho_tc1'

TestMapMaticObjectLayer = {}

    function TestMapMaticObjectLayer:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("object_layer1")
        lu.assertEquals(layer:type(), "ObjectLayer")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__type_of()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("object_layer1")
        lu.assertIsTrue(layer:typeOf("Layer"))
    end

    --[[ ObjectLayer:init ]]

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_init__map_object()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertEquals(layer.objects[1]:type(), "MapObject")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_init__object_added_to_map_lookup_table()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertIsTrue(layer.objects[1] == map.objects.layers[layer.objects[1].id])
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_init__draw_order__top_down()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertEquals(layer.objects[1].name, "object_2")
        lu.assertEquals(layer.objects[2].name, "object_1")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_init__draw_order__manual()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_2")
        lu.assertEquals(layer.objects[1].name, "object_3")
        lu.assertEquals(layer.objects[2].name, "object_4")
    end

    --[[ ObjectLayer:hasObject ]]

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_has_object__true()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertIsTrue(layer:hasObject("object_1"))
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_has_object__false()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertIsFalse(layer:hasObject("object_3"))
    end

    --[[ ObjectLayer:getObject ]]

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_object__by_id()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        local object = layer:getObject(6)
        lu.assertEquals(object.name, "object_2")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_object__by_name()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        local object = layer:getObject("object_2")
        lu.assertEquals(object.name, "object_2")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_object__param1_not_string_or_number()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertErrorMsgContains("getObject : objectid must be either a string name or the numerical id : id=true",
            layer.getObject, layer, true)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_object__object_does_not_exist_on_layer()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertErrorMsgContains("getObject : object with specified object id does not exist on object layer : id=notanobject",
            layer.getObject, layer, "notanobject")
    end

    --[[ ObjectLayer:getObjects ]]

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_objects()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_1")
        lu.assertIsTrue(layer:getObjects() == layer.objects)
    end

    --[[ ObjectLayer:getAllObjectsWithName ]]

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_all_objects_with_name__number_in_list()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local objects = layer:getAllObjectsWithName("objectname")
        lu.assertEquals(#objects, 5)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_all_objects_with_name__list()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local objects = layer:getAllObjectsWithName("notobjectname")
        lu.assertEquals({objects[1].id, objects[2].id}, {28, 33})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_all_objects_with_name__name_not_found()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local objects = layer:getAllObjectsWithName("notaname")
        lu.assertEquals(#objects, 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer_get_all_objects_with_name__no_name_provided()
        local map = MapFactory(object_10x10)
        local layer = map:getLayer("object_layer_4")
        local objects = layer:getAllObjectsWithName()
        lu.assertIsTrue(objects == layer.objects)
    end

    --============================
    -- Layer
    --============================

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_map()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsTrue(layer:getMap() == map)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_child__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertIsTrue(layer:isChild())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_child__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:isChild())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__has_parent__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertIsTrue(layer:hasParent())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__has_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:hasParent())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:isParent())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__has_children__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:hasChildren())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_parent()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertIsTrue(layer:getParent() == map:getLayer("group_layer"))
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_layer_type()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getLayerType(), "objectgroup")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_layer_path()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertEquals(layer:getLayerPath(), "group_layer.child_object_layer")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getIndex(), 2)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_group_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getGroupIndex(), 2)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_group_index__child()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertEquals(layer:getGroupIndex(), 3)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertEquals({layer:getParallax()}, {8, 15})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertEquals(layer:getParallaxX(), 8)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertEquals(layer:getParallaxY(), 15)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__set_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")

        layer:setParallax(0.5, 2)

        -- parent: 2, 3 ; layer: 0.5, 2
        lu.assertEquals({layer:getParallax()}, {1, 6})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__set_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")

        layer:setParallaxX(0.5)

        -- parent: 2, 3 ; layer: 0.5, 5
        lu.assertEquals({layer:getParallax()}, {1, 15})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__set_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")

        layer:setParallaxY(2)

        -- parent: 2, 3 ; layer: 4, 2
        lu.assertEquals({layer:getParallax()}, {8, 6})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_visible__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_visible__false()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_visible__parent_visible()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_object_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__is_visible__parent_not_visible()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_object_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getOffsetX(), 50)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getOffsetY(), 60)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__layer__get_opacity()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_object_layer")
        lu.assertAlmostEquals(layer:getOpacity(), 0.04, 0.00001)
    end

    --============================
    -- TObject
    --============================

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_id()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getId(), 3)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getName(), "object_layer")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setName("new_layer_name")

        lu.assertEquals(layer:getName(), "new_layer_name")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getX(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getY(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setPosition(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setX(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setY(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__move_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:moveBy(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setRotation(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__rotate_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:rotateBy(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getScaleX(), 1)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getScaleY(), 1)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setScale(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setScaleX(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setScaleY(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__scale_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:scaleBy(3, 5)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getOriginX(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getOriginY(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOrigin(10, 20)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOriginX(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOriginY(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__draw_coords()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getDrawCoords()}, {50, 60, 0, 1, 1, 0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_dimensions()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getDimensions()}, {0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_width()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getWidth(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_height()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getHeight(), 0)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_rect()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getRect()}, {0, 0, 0, 0})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals({layer:getOffsets()}, {50, 60})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOffsets(40, 50)

        lu.assertEquals({layer:getOffsets()}, {40, 50})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOffsetX(40)

        lu.assertEquals({layer:getOffsets()}, {40, 60})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOffsetY(40)

        lu.assertEquals({layer:getOffsets()}, {50, 40})
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_visibility__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setVisibility(true)

        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_visibility__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setVisibility(false)

        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_opacity()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setOpacity(0.1)

        lu.assertEquals(layer.opacity, 0.1)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__get_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getProperty("custom_object_property"), "test object string")
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")

        layer:setProperty("additional_property", "additional property string")

        lu.assertEquals(layer:getProperty("additional_property"), "additional property string")
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__set_num_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertEquals(layer:getNumProperties(), 2)
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__has_property_key__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsTrue(layer:hasPropertyKey("custom_object_property"))
        lu.assertIsTrue(layer:hasPropertyKey("custom_map_property"))
    end

    function TestMapMaticObjectLayer:test_mapmatic_object_layer__tobject__has_property_key__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("object_layer")
        lu.assertIsFalse(layer:hasPropertyKey("not_a_property"))
    end




























