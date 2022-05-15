
local mapdir = 'assets/maps/orthogonal/'

local empty_map            = mapdir .. 'empty_8x8_ortho'
local empty_map_image      = mapdir .. 'empty_8x8_ortho__image'
local layers_8x8_ortho     = mapdir .. 'layers_8x8_ortho'
local simple_8x8_ortho_tc1 = mapdir .. 'simple_8x8_ortho_tc1'

TestMapMaticImageLayer = {}

    function TestMapMaticImageLayer:tearDown()
        MapFactory:clearCache()
    end

    --[[ ImageLayer ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer__class_name()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:type(), "ImageLayer")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__type_of()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsTrue(layer:typeOf("Layer"))
    end

    --[[ ImageLayer:init ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__image_path()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertStrContains(layer.path, "image_layer_bkgrd.png")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__image_path_no_image()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer_no_image")
        lu.assertEquals(layer.path, "")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_false")
        lu.assertIsFalse(layer.repeatx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_false")
        lu.assertIsFalse(layer.repeaty)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertIsTrue(layer.repeatx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        lu.assertIsTrue(layer.repeaty)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx_missing()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer.repeatx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty_missing()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer.repeaty)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__mirroredx__default()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer.mirroredx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__mirroredy__default()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer.mirroredy)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__no_image_no_quad()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__image_but_no_repeat__no_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx__quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertNotIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty__quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        lu.assertNotIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx__quad_width()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        local _, _, quadW, quadH = layer.quad:getViewport()
        lu.assertEquals({quadW, quadH}, {map:getCanvas():getWidth(), layer.image:getHeight()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty__quad_height()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        local _, _, quadW, quadH = layer.quad:getViewport()
        lu.assertEquals({quadW, quadH}, {layer.image:getWidth(), map:getCanvas():getHeight()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeatx__wrap_mode_default()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        local horiz, vert = layer.image:getWrap()
        lu.assertEquals({horiz, vert}, {"repeat", "clampzero"})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__repeaty__wrap_mode_default()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        local horiz, vert = layer.image:getWrap()
        lu.assertEquals({horiz, vert}, {"clampzero", "repeat"})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_init__no_repeat__wrap_mode_default()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local horiz, vert = layer.image:getWrap()
        lu.assertEquals({horiz, vert}, {"clamp", "clamp"})
    end

    --[[ ImageLayer:getImage ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_image()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local img = layer:getImage()
        lu.assertEquals(img:type(), "Image")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_image__no_image()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsNil(layer:getImage())
    end

    --[[ ImageLayer:getQuad ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertEquals(layer:getQuad():type(), "Quad")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_quad__no_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsNil(layer:getQuad())
    end

    --[[ ImageLayer:hasImage ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_has_image__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsTrue(layer:hasImage())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_has_image__false()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:hasImage())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_has_image__image_not_image_type__false()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        layer.image = love.graphics.newQuad(0, 0, 0, 0, 0, 0)
        lu.assertIsFalse(layer:hasImage())
    end

    --[[ ImageLayer:getWidth ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_width__image__no_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local img2compare = love.graphics.newImage("assets/image_layer_bkgrd.png")

        lu.assertEquals(layer:getWidth(), img2compare:getWidth())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_width__no_image__no_repeat()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getWidth(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_width__image__with_repeat_x()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertEquals(layer:getWidth(), map:getCanvas():getWidth())
    end

    --[[ ImageLayer:getHeight ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_height__image__no_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local img2compare = love.graphics.newImage("assets/image_layer_bkgrd.png")

        lu.assertEquals(layer:getHeight(), img2compare:getHeight())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_height__no_image__no_repeat()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getHeight(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_height__image__with_repeat_y()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        lu.assertEquals(layer:getHeight(), map:getCanvas():getHeight())
    end

    --[[ ImageLayer:getRepeat ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertEquals({layer:getRepeat()}, {true, false})
    end

    --[[ ImageLayer:getRepeatX ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_repeatx__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")
        lu.assertIsTrue(layer:getRepeatX())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_repeatx__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:getRepeatX())
    end

    --[[ ImageLayer:getRepeatY ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_repeaty__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")
        lu.assertIsTrue(layer:getRepeatY())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_repeaty__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:getRepeatY())
    end

    --[[ ImageLayer:setRepeat ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeat(true, false)
        lu.assertEquals({layer.repeatx, layer.repeaty}, {true, false})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat__build_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeat(true, false)
        lu.assertNotIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat__remove_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")

        lu.assertNotIsNil(layer.quad)
        layer:setRepeat(false, false)
        lu.assertIsNil(layer.quad)
    end

    --[[ ImageLayer:setRepeatX ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_x()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeatX(true)
        lu.assertIsTrue(layer.repeatx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_x__build_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeatX(true)
        lu.assertNotIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_x__quad_height()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setRepeatX(true)
        local _, _, viewW, viewH = layer.quad:getViewport()

        lu.assertNotIsNil(layer.quad)
        lu.assertEquals({viewW, viewH}, {map:getCanvas():getWidth(), layer:getImage():getHeight()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_x__remove_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")

        lu.assertNotIsNil(layer.quad)
        layer:setRepeatX(false)
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_x__do_not_remove_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")

        lu.assertNotIsNil(layer.quad)
        layer:setRepeatX(false)
        lu.assertNotIsNil(layer.quad)
    end

    --[[ ImageLayer:setRepeatY ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_y()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeatY(true)
        lu.assertIsTrue(layer.repeaty)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_y__build_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer:setRepeatY(true)
        lu.assertNotIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_y__quad_height()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setRepeatY(true)
        local _, _, viewW, viewH = layer.quad:getViewport()

        lu.assertNotIsNil(layer.quad)
        lu.assertEquals({viewW, viewH}, {layer:getImage():getWidth(), map:getCanvas():getHeight()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_y__remove_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeaty_true")

        lu.assertNotIsNil(layer.quad)
        layer:setRepeatY(false)
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_repeat_y__do_not_remove_quad()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatx_true")

        lu.assertNotIsNil(layer.quad)
        layer:setRepeatY(false)
        lu.assertNotIsNil(layer.quad)
    end

    --[[ ImageLayer:getMirrored ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getMirrored()}, {false, false})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer.mirroredx, layer.mirroredy = true, true

        lu.assertEquals({layer:getMirrored()}, {true, true})
    end

    --[[ ImageLayer:getMirroredX ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored_x__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:getMirroredX())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored_x__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer.mirroredx = true
        lu.assertIsTrue(layer:getMirroredX())
    end

    --[[ ImageLayer:getMirroredY ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored_y__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:getMirroredY())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_get_mirrored_y__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        layer.mirroredy = true
        lu.assertIsTrue(layer:getMirroredY())
    end

    --[[ ImageLayer:setMirrored ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirrored(true, true)

        lu.assertEquals({layer.mirroredx, layer.mirroredy}, {true, true})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirrored(false, false)

        lu.assertEquals({layer.mirroredx, layer.mirroredy}, {false, false})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored__no_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirrored(true, true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"clamp", "clamp"})
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored__with_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirrored(true, true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"mirroredrepeat", "mirroredrepeat"})
        lu.assertNotIsNil(layer.quad)
    end

    --[[ ImageLayer:setMirroredX ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_x__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirroredX(true)

        lu.assertIsTrue(layer.mirroredx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_x__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirroredX(false)

        lu.assertIsFalse(layer.mirroredx)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_x__no_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirroredX(true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"clamp", "clamp"})
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_x__with_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirroredX(true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"mirroredrepeat", "repeat"})
        lu.assertNotIsNil(layer.quad)
    end

    --[[ ImageLayer:setMirroredY ]]

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_y__true()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirroredY(true)

        lu.assertIsTrue(layer.mirroredy)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_y__false()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirroredY(false)

        lu.assertIsFalse(layer.mirroredy)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_y__no_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")

        layer:setMirroredY(true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"clamp", "clamp"})
        lu.assertIsNil(layer.quad)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer_set_mirrored_y__with_repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")

        layer:setMirroredY(true)
        local horiz, vert = layer:getImage():getWrap()

        lu.assertEquals({horiz, vert}, {"repeat", "mirroredrepeat"})
        lu.assertNotIsNil(layer.quad)
    end


    --============================
    -- Layer
    --============================

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_map()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsTrue(layer:getMap() == map)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_child__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsTrue(layer:isChild())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_child__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:isChild())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__has_parent__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsTrue(layer:hasParent())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__has_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:hasParent())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_parent__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsFalse(layer:isParent())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__has_children__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsFalse(layer:hasChildren())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_parent()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsTrue(layer:getParent() == map:getLayer("group_layer"))
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_layer_type()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getLayerType(), "imagelayer")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_layer_path()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertEquals(layer:getLayerPath(), "group_layer.child_image_layer")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getIndex(), 3)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_group_index()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertEquals(layer:getGroupIndex(), 4)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertEquals({layer:getParallax()}, {8, 15})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertEquals(layer:getParallaxX(), 8)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertEquals(layer:getParallaxY(), 15)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__set_parallax()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")

        layer:setParallax(0.5, 2)

        -- parent: 2, 3 ; layer: 0.5, 2
        lu.assertEquals({layer:getParallax()}, {1, 6})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__set_parallax_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")

        layer:setParallaxX(0.5)

        -- parent: 2, 3 ; layer: 0.5, 5
        lu.assertEquals({layer:getParallax()}, {1, 15})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__set_parallax_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")

        layer:setParallaxY(2)

        -- parent: 2, 3 ; layer: 4, 2
        lu.assertEquals({layer:getParallax()}, {8, 6})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_visible__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_visible__false()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_visible__parent_visible()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("group_layer.child_image_layer")
        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__is_visible__parent_not_visible()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_image_layer")
        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getOffsetX(), 30)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getOffsetY(), 40)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__layer__get_opacity()
        local map = MapFactory(simple_8x8_ortho_tc1)
        local layer = map:getLayer("group_layer.child_group_layer.child_child_image_layer")
        lu.assertAlmostEquals(layer:getOpacity(), 0.04, 0.00001)
    end

    --============================
    -- TObject
    --============================

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_id()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getId(), 4)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getName(), "image_layer")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_name()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setName("new_layer_name")

        lu.assertEquals(layer:getName(), "new_layer_name")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getX(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getY(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_position()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setPosition(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setX(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setY(10)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__move_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:moveBy(10, 20)

        lu.assertEquals({layer:getPosition()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_rotation()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setRotation(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__rotate_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:rotateBy(20)

        lu.assertEquals(layer:getRotation(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getScaleX(), 1)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getScaleY(), 1)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_scale()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setScale(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_scale_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setScaleX(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_scale_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setScaleY(3)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__scale_by()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:scaleBy(3, 5)

        lu.assertEquals({layer:getScale()}, {1, 1})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getOriginX(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getOriginY(), 0)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_origin()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOrigin(10, 20)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_origin_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOriginX(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_origin_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOriginY(10)

        lu.assertEquals({layer:getOrigin()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__draw_coords()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getDrawCoords()}, {30, 40, 0, 1, 1, 0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_dimensions()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local img2compare = love.graphics.newImage("assets/image_layer_bkgrd.png")

        lu.assertEquals({layer:getDimensions()}, {img2compare:getDimensions()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_dimensions__no_image()
        local map = MapFactory(empty_map)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getDimensions()}, {0, 0})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_dimensions__repeat()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("repeatxy_true")
        lu.assertEquals({layer:getDimensions()}, {map:getCanvas():getDimensions()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_rect()
        local map = MapFactory(empty_map_image)
        local layer = map:getLayer("image_layer")
        local img = love.graphics.newImage("assets/image_layer_bkgrd.png")
        lu.assertEquals({layer:getRect()}, {0, 0, img:getWidth(), img:getHeight()})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals({layer:getOffsets()}, {30, 40})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_offsets()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOffsets(50, 60)

        lu.assertEquals({layer:getOffsets()}, {50, 60})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_offset_x()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOffsetX(50)

        lu.assertEquals({layer:getOffsets()}, {50, 40})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_offset_y()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOffsetY(60)

        lu.assertEquals({layer:getOffsets()}, {30, 60})
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_visibility__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setVisibility(true)

        lu.assertIsTrue(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_visibility__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setVisibility(false)

        lu.assertIsFalse(layer:isVisible())
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_opacity()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setOpacity(0.1)

        lu.assertEquals(layer.opacity, 0.1)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__get_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getProperty("custom_image_property"), "test image string")
        lu.assertEquals(layer:getProperty("custom_map_property"), "test map string")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_property()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")

        layer:setProperty("additional_property", "additional property string")

        lu.assertEquals(layer:getProperty("additional_property"), "additional property string")
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__set_num_properties()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertEquals(layer:getNumProperties(), 2)
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__has_property_key__true()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsTrue(layer:hasPropertyKey("custom_image_property"))
        lu.assertIsTrue(layer:hasPropertyKey("custom_map_property"))
    end

    function TestMapMaticImageLayer:test_mapmatic_image_layer__tobject__has_property_key__false()
        local map = MapFactory(layers_8x8_ortho)
        local layer = map:getLayer("image_layer")
        lu.assertIsFalse(layer:hasPropertyKey("not_a_property"))
    end




































