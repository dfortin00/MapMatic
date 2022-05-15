
local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho = mapdir .. 'batch_8x8_ortho__ts1_tc1'
local anim_8x8_ortho  = mapdir .. 'anim_8x8_ortho_ts1'

TestMapMaticTileInstance = {}

    function TestMapMaticTileInstance:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        lu.assertEquals(instance:type(), "TileInstance")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__type_of()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        lu.assertIsTrue(instance:typeOf("TObject"))
    end

    --[[ TileInstance:init ]]

    --======
    -- Owner
    --======

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__owner()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        lu.assertIsTrue(instance.owner == layer)
    end

    --=====
    -- Tile
    --=====

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__tile()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        lu.assertEquals(instance.tile:type(), "Tile")
    end

    --===============
    -- XY Coordinates
    --===============

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__tile_x_and_y__map_corner()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals({instance.x, instance.y}, {0, 0})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__tile_x_and_y__inside_map()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(3, 2)

        lu.assertEquals({instance.x, instance.y}, {48, 32})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__tile_x_and_y__atlas__with_tileset_offset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local instance = layer:getTileInstance(2, 3)

        local x = 2 * map:getTileWidth()
        local y = 3 * map:getTileHeight() - map:getTileHeight()

        lu.assertEquals({instance.x, instance.y}, {x, y})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__tile_x_and_y__tile_collection__with_tileset_offset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        -- Tiles are placed on the bottom left corner, so col remains same, but row requires +1.
        local x = 1 * map:getTileWidth()
        local y = (5 + 1) * map:getTileHeight() - instance:getHeight()

        lu.assertEquals({instance.x, instance.y}, {x, y})
    end

    --=========
    -- Rotation
    --=========

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__rotation()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertEquals(instance.rotation, 0)
    end

    --======
    -- Scale
    --======

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__scale()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertEquals({instance.sx, instance.sy}, {1, 1})
    end

    --=======
    -- Origin
    --=======

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__origin()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertEquals({instance.ox, instance.oy}, {0, 0})
    end

    --===========
    -- Animations
    --===========

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__animation__no_animation()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertIsNil(instance.animation)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__animation__with_animation()
        local map = MapFactory(anim_8x8_ortho)
        local layer = map:getLayer("background")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance.animation:type(), "TileAnimation")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__animation__added_to_lookup_table()
        local map = MapFactory(anim_8x8_ortho)
        local layer = map:getLayer("background")
        local instance = layer:getTileInstance(0, 0)

        lu.assertIsTrue(map.animations["background"][1].animation == instance.animation)
    end

    --==============
    -- SpriteBatches
    --==============

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__batch__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertNotIsNil(instance.batch)
        lu.assertNotIsNil(instance.batchid)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__batch__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertNotIsNil(instance.batch)
        lu.assertNotIsNil(instance.batchid)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_init__batch__no_batch_draw()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsNil(instance.batch)
        lu.assertIsNil(instance.batchid)
    end

    ------------------------------------

    --[[ TileInstance:getOwner ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_owner()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getOwner() == layer)
    end

    --[[ TileInstance:getTile ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_tile()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getTile() == map.tiles[25])
    end

    --[[ TileInstance:getTileSet ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_tile_set()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getTileSet() == map.tilesets[1])
    end

    --[[ TileInstance:getId ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_id()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance:getId(), 23)
    end

    --[[ TileInstance:getGid ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_gid()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance:getGid(), 24)
    end

    --[[ TileInstance:setPosition ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_position()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setPosition(20, 30)
        lu.assertEquals({instance.x, instance.y}, {20, 30})
    end

    --[[ TileInstance:moveBy ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_move_by()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:moveBy(10, 20)
        lu.assertEquals({instance.x, instance.y}, {32 + 10, 48 + 20})
    end

    --[[ TileInstance:setRotation ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_rotation()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setRotation(math.rad(45))

        lu.assertEquals(instance:getRotation(), math.rad(45))
    end

    --[[ TileInstance:rotateBy ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_rotate_by()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setRotation(math.rad(45))
        instance:rotateBy(math.rad(30))

        lu.assertAlmostEquals(instance:getRotation(), math.rad(45 + 30), 0.000001)
    end

    --[[ TileInstance:setScale ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_scale()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setScale(0.5, 0.75)

        lu.assertEquals({instance:getScale()}, {0.5, 0.75})
    end

    --[[ TileInstance:setScaleX ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_scale_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setScaleX(0.5)

        lu.assertEquals({instance:getScale()}, {0.5, 1})
    end

    --[[ TileInstance:setScaleY ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_scale_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setScaleY(0.75)

        lu.assertEquals({instance:getScale()}, {1, 0.75})
    end

    --[[ TileInstance:scaleBy ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_scale_by()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setScale(0.5, 0.6)
        instance:scaleBy(0.1, 0.2)

        lu.assertEquals({instance:getScale()}, {0.6, 0.8})
    end

    --[[ TileInstance:getDimensions ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_dimensions()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        lu.assertEquals({instance:getDimensions()}, {81, 76})
    end

    --[[ TileInstance:getWidth ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_width()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        lu.assertEquals(instance:getWidth(), 81)
    end

    --[[ TileInstance:getHeight ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_height()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        lu.assertEquals(instance:getHeight(), 76)
    end

    --[[ TileInstance:setOrigin ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_origin()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setOrigin(10, 20)

        lu.assertEquals({instance.ox, instance.oy}, {10, 20})
    end

    --[[ TileInstance:setOriginX ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_origin_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setOriginX(10)

        lu.assertEquals({instance:getOrigin()}, {10, 0})
    end

    --[[ TileInstance:setOriginY ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_set_origin_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        instance:setOriginY(20)

        lu.assertEquals({instance:getOrigin()}, {0, 20})
    end

    --[[ TileInstance:getOffsetX ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        lu.assertEquals(instance:getOffsetX(), 10)
    end

    --[[ TileInstance:getOffsetY ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        lu.assertEquals(instance:getOffsetY(), 20)
    end

    --[[ TileInstance:getImage ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_image__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getImage() == map.tilesets[1].image)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_image__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        local gid = instance:getTile():getTileSet():getFirstGid()

        lu.assertIsTrue(instance:getImage() == map.tiles[gid].image)
    end

    --[[ TileInstance:getQuad ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_quad__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)
        local gid = instance:getGid()

        lu.assertIsTrue(instance:getQuad() == map.tiles[gid].quad)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_quad__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsNil(instance:getQuad())
    end

    --[[ TileInstance:usesBatch ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_uses_batch__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:usesBatch())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_uses_batch__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsFalse(instance:usesBatch())
    end

    --[[ TileInstance:getBatch ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getBatch() == layer.batches[1])
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:getBatch() == layer.batches[2][0])
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch__no_batch()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsNil(instance:getBatch())
    end

    --[[ TileInstance:getBatchId ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch_id__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance:getBatchId(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch_id__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance:getBatchId(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_batch_id__no_batch()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsNil(instance:getBatchId())
    end

    --[[ TileInstance:isAtlas ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_is_atlas__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsTrue(instance:isAtlas())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_is_atlas__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertIsFalse(instance:isAtlas())
    end

    --[[ TileInstance:getImageType ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_image_type__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertEquals(instance:getImageType(), "atlas")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_image_type__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__fit")
        local instance = layer:getTileInstance(1, 1)

        lu.assertEquals(instance:getImageType(), "collection")
    end

    --[[ TileInstance:hasObject ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_object__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 7)

        lu.assertIsTrue(instance:hasObject("ellipse_object"))
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_object__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertIsFalse(instance:hasObject("ellipse_object"))
    end

    --[[ TileInstance:hasObjects ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_objects__true()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 7)

        lu.assertIsTrue(instance:hasObjects())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_objects__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        lu.assertIsFalse(instance:hasObjects())
    end

    --[[ TileInstance:getObject ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_object()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 7)

        lu.assertIsTrue(instance:getObject("rect_object") == instance.tile.objectGroup.objects[1])
    end

    --[[ TileInstance:getObjects ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_objects()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 7)

        lu.assertIsTrue(instance:getObjects() == instance.tile.objectGroup.objects)
    end

    --[[ TileInstance:hasAnimation ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_animation__true()
        local map = MapFactory(anim_8x8_ortho)
        local layer = map:getLayer("background")
        local instance = layer:getTileInstance(0, 0)

        lu.assertIsTrue(instance:hasAnimation())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_has_animation__false()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertIsFalse(instance:hasAnimation())
    end

    --[[ TileInstance:getAnimation ]]

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_animation__has_animation()
        local map = MapFactory(anim_8x8_ortho)
        local layer = map:getLayer("background")
        local instance = layer:getTileInstance(0, 0)

        lu.assertEquals(instance:getAnimation():type(), "TileAnimation")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance_get_animation__does_not_have_animation()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertIsNil(instance:getAnimation())
    end

    --================================
    -- TObject
    --================================

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_name()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)
        lu.assertEquals(instance:getName(), "")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_name()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(0, 0)

        instance:setName("tile_instance")

        lu.assertEquals(instance:getName(), "")
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_position()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals({instance:getPosition()}, {32, 48})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getX(), 32)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getY(), 48)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_rotation()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getRotation(), 0)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_scale()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals({instance:getScale()}, {1, 1})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_scale_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getScaleX(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_scale_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getScaleY(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_origin()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals({instance:getOrigin()}, {0, 0})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_origin_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getOriginX(), 0)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_origin_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        lu.assertEquals(instance:getOriginY(), 0)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_draw_coords()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("ts_layer__fit")
        local instance = layer:getTileInstance(2, 3)

        -- x, y, r, sx, sy, ox, oy
        lu.assertEquals({instance:getDrawCoords()}, {32, 48, 0, 1, 1, 0, 0})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_rect()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        -- x, y, r, sx, sy, ox, oy
        -- x = col * tilewidth + tileset.offsetx
        -- y = (row + 1) * tileheight + tileset.offsety - tileheight
        lu.assertEquals({instance:getDrawCoords()}, {1 * 16 + 10, 6 * 16 + 20 - 76, 0, 1, 1, 0, 0})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertEquals({instance:getOffsets()}, {10, 20})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setOffsets(30, 40)

        lu.assertEquals({instance:getOffsets()}, {10, 20})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setOffsetX(30)

        lu.assertEquals({instance:getOffsets()}, {10, 20})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setOffsetY(30)

        lu.assertEquals({instance:getOffsets()}, {10, 20})
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__is_visible()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertIsTrue(instance:isVisible())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_visibility()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setVisibility(false)

        lu.assertIsTrue(instance:isVisible())
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_opacity()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertEquals(instance:getOpacity(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_opacity()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setOpacity(0.5)

        lu.assertEquals(instance:getOpacity(), 1)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_property()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertIsNil(instance:getProperty("nothing"))
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__set_property()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)

        instance:setProperty("nothing", "not a value")
        lu.assertIsNil(instance:getProperty("nothing"))
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__get_num_properties()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertEquals(instance:getNumProperties(), 0)
    end

    function TestMapMaticTileInstance:test_mapmatic_tile_instance__tobject__has_property_key()
        local map = MapFactory(batch_8x8_ortho)
        local layer = map:getLayer("tc_layer__does_not_fit")
        local instance = layer:getTileInstance(1, 5)
        lu.assertIsFalse(instance:hasPropertyKey("nothing"))
    end










































