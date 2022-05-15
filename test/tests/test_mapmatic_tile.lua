
local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho = mapdir .. 'batch_8x8_ortho__ts1_tc1'

TestMapMaticTile = {}

    function TestMapMaticTile:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticTile:test_mapmatic_tile__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:type(), "Tile")
    end

    function TestMapMaticTile:test_mapmatic_tile__type_of()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertIsTrue(tile:typeOf("TObject"))
    end

    --[[ Tile:init ]]

    --========
    -- Tileset
    --========

    function TestMapMaticTile:test_mapmatic_tile_init__tileset()
        local map = MapFactory(batch_8x8_ortho)

        for _, tile in pairs(map.tiles) do
            lu.assertNotIsNil(tile.tileset)
        end
    end

    --=====
    -- Tile
    --=====

    function TestMapMaticTile:test_mapmatic_tile_init__tile__gid()
        local map = MapFactory(batch_8x8_ortho)

        for _, tile in pairs(map.tiles) do
            lu.assertEquals(tile.gid, map.tilesets[tile:getTileSetIndex()]:getFirstGid() + tile.id)
        end
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__width__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile.width, tileset.tilewidth)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__width__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile.width, tile.image:getWidth())
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__height__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile.height, tileset.tileheight)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__height__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile.height, tile.image:getHeight())
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile.properties:get("tile_prop"), "tile property value")
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile__tileset_properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile.properties:get("tileset_prop"), "tileset property value")
    end

    --======
    -- Image
    --======

    function TestMapMaticTile:test_mapmatic_tile_init__image__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile.image == map.tilesets[tile:getTileSetIndex()].image)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__image__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsFalse(tile.image == map.tilesets[tile:getTileSetIndex()].image)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__image__quad__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertNotIsNil(tile.quad)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__image__no_quad__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsNil(tile.quad)
    end

    --========
    -- Drawing
    --========

    function TestMapMaticTile:test_mapmatic_tile_init__scale()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals({tile.sx, tile.sy}, {1, 1})
    end

    function TestMapMaticTile:test_mapmatic_tile_init__rotation()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile.rotation, 0)
    end

    --=============
    -- Tile Objects
    --=============

    function TestMapMaticTile:test_mapmatic_tile_init__objects()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertNotIsNil(tile.objectGroup)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__objects__type()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile.objectGroup.objects[1]:type(), "MapObject")
    end

    function TestMapMaticTile:test_mapmatic_tile_init__objects__properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local object = tile.objectGroup.objects[1]
        lu.assertEquals(object.properties:get("tile_object_prop"), "tile object property value")
    end

    function TestMapMaticTile:test_mapmatic_tile_init__objects__tileset_properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local object = tile.objectGroup.objects[1]
        lu.assertEquals(object.properties:get("tileset_prop"), "tileset property value")
    end

    function TestMapMaticTile:test_mapmatic_tile_init__objects__tile_properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local object = tile.objectGroup.objects[1]
        lu.assertEquals(object.properties:get("tile_prop"), "tile property value")
    end

    --===============
    -- Tile Animation
    --===============

    function TestMapMaticTile:test_mapmatic_tile_init__tile_animation()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid() + 1)
        lu.assertNotIsNil(tile.animation)
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile_animation__type()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid() + 1)
        lu.assertEquals(tile.animation:type(), "TileAnimation")
    end

    function TestMapMaticTile:test_mapmatic_tile_init__tile_animation__no_animation()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsNil(tile.animation)
    end

    ---------------------

    --[[ Tile:getGid ]]

    function TestMapMaticTile:test_mapmatic_tile_get_gid()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getGid(), 1)
    end

    --[[ Tile:getTileSet ]]

    function TestMapMaticTile:test_mapmatic_tile_get_tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:getTileSet() == tileset)
    end

    --[[ Tile:getTileSetIndex ]]

    function TestMapMaticTile:test_mapmatic_tile_get_tileset_index()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:getTileSetIndex() == tileset.index)
    end

    --[[ Tile:isAtlas ]]

    function TestMapMaticTile:test_mapmatic_tile_get_atlas__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:isAtlas())
    end

    function TestMapMaticTile:test_mapmatic_tile_get_atlas__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsFalse(tile:isAtlas())
    end

    --[[ Tile:getImage ]]

    function TestMapMaticTile:test_mapmatic_tile_get_image__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:getImage() == tileset.image)
    end

    function TestMapMaticTile:test_mapmatic_tile_get_image__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:getImage() == tile.image)
    end

    --[[ Tile:getQuad ]]

    function TestMapMaticTile:test_mapmatic_tile_get_quad__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertNotIsNil(tile:getQuad())
    end

    function TestMapMaticTile:test_mapmatic_tile_get_quad__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsNil(tile:getQuad())
    end

    --[[ Tile:getImageType ]]

    function TestMapMaticTile:test_mapmatic_tile_get_image_type__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getImageType(), "atlas")
    end

    function TestMapMaticTile:test_mapmatic_tile_get_image_type__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getImageType(), "collection")
    end

    --[[ Tile:getWidth ]]

    function TestMapMaticTile:test_mapmatic_tile_get_width__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getWidth(), tileset:getTileWidth())
    end

    function TestMapMaticTile:test_mapmatic_tile_get_width__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile:getWidth(), tile.image:getWidth())
    end

    --[[ Tile:getHeight ]]

    function TestMapMaticTile:test_mapmatic_tile_get_height__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getHeight(), tileset:getTileHeight())
    end

    function TestMapMaticTile:test_mapmatic_tile_get_height__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile:getHeight(), tile.image:getHeight())
    end

    --[[ Tile:getOffsets ]]

    function TestMapMaticTile:test_mapmatic_tile_get_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset32x32")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals({tile:getOffsets()}, {10, 20})
    end

    --[[ Tile:getOffsetX ]]

    function TestMapMaticTile:test_mapmatic_tile_get_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset32x32")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getOffsetX(), 10)
    end

    --[[ Tile:getOffsetY ]]

    function TestMapMaticTile:test_mapmatic_tile_get_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset32x32")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getOffsetY(), 20)
    end

    --[[ Tile:getScale ]]

    function TestMapMaticTile:test_mapmatic_tile_get_scale()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals({tile:getScale()}, {1, 1})
    end

    --[[ Tile:hasAnimation ]]

    function TestMapMaticTile:test_mapmatic_tile_has_animation__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 1)
        lu.assertIsTrue(tile:hasAnimation())
    end

    function TestMapMaticTile:test_mapmatic_tile_has_animation__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsFalse(tile:hasAnimation())
    end

    --[[ Tile:getAnimation ]]

    function TestMapMaticTile:test_mapmatic_tile_get_animation()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 1)
        lu.assertNotIsNil(tile:getAnimation())
    end

    function TestMapMaticTile:test_mapmatic_tile_get_animation__no_animation()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsNil(tile:getAnimation())
    end

    --[[ Tile:hasObject ]]

    function TestMapMaticTile:test_mapmatic_tile_has_object__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        lu.assertIsTrue(tile:hasObject("rect_object"))
    end

    function TestMapMaticTile:test_mapmatic_tile_has_object__true__returns_object()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local _, object = tile:hasObject("rect_object")
        lu.assertEquals(object.name, "rect_object")
    end

    function TestMapMaticTile:test_mapmatic_tile_has_object__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        lu.assertIsFalse(tile:hasObject("not an object"))
    end

    function TestMapMaticTile:test_mapmatic_tile_has_object__false__returns_error_message()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local _, message = tile:hasObject(999)
        lu.assertStrContains(message,
            "getObject : object with specified object id does not exist on object layer : id=999")
    end

    --[[ Tile:hasObjects ]]

    function TestMapMaticTile:test_mapmatic_tile_has_objects__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:hasObjects())
    end

    function TestMapMaticTile:test_mapmatic_tile_has_objects__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid() + 1)
        lu.assertIsFalse(tile:hasObjects())
    end

    --[[ Tile:getObject ]]

    function TestMapMaticTile:test_mapmatic_tile_get_object__by_index()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local object = tile:getObject(1)
        lu.assertIsTrue(object == map.objects.tiles[tileset:getFirstGid()])
    end

    function TestMapMaticTile:test_mapmatic_tile_get_object__by_name()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        local object = tile:getObject("rect_object")
        lu.assertIsTrue(object == map.objects.tiles[tileset:getFirstGid()])
    end

    function TestMapMaticTile:test_mapmatic_tile_get_object__tile_does_not_have_objects()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid() + 1)

        lu.assertErrorMsgContains("getObject: specified tile does not have any object groups associated : id=1",
            tile.getObject, tile, 1)
    end

    function TestMapMaticTile:test_mapmatic_tile_get_object__param1_not_number_or_string()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        lu.assertErrorMsgContains("getObject : objectid must be either a string name or the numerical id : id=true",
            tile.getObject, tile, true)
    end

    function TestMapMaticTile:test_mapmatic_tile_get_object__object_id_does_not_exist()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        lu.assertErrorMsgContains("getObject : object with specified object id does not exist on object layer : id=999",
            tile.getObject, tile, 999)
    end

    --[[ Tile:getObjects ]]

    function TestMapMaticTile:test_mapmatic_tile_get_objects__has_objects()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        local objects = tile:getObjects()
        lu.assertEquals(#objects, 4)
    end

    function TestMapMaticTile:test_mapmatic_tile_get_objects__does_not_have_objects()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid() + 1)

        local objects = tile:getObjects()
        lu.assertEquals(#objects, 0)
    end

    --============================
    -- TObject
    --============================

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_id()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getId(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_name()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getName(), "")
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_name()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        tile:setName("new_layer_name")
        lu.assertIsNil(tile.name)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_position()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals({tile:getPosition()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_x()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getX(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_y()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getY(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_position()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setPosition(10, 20)

        lu.assertEquals({tile:getPosition()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_x()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setX(10)

        lu.assertEquals({tile:getPosition()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_y()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setY(10)

        lu.assertEquals({tile:getPosition()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__move_by()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:moveBy(10, 20)

        lu.assertEquals({tile:getPosition()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_rotation()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getRotation(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_rotation()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setRotation(math.rad(45))

        lu.assertEquals(tile:getRotation(), math.rad(45))
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__rotate_by()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:rotateBy(math.rad(45))

        lu.assertEquals(tile:getRotation(), math.rad(45))
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_scale()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals({tile:getScale()}, {1, 1})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_scale_x()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getScaleX(), 1)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_scale_y()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getScaleY(), 1)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_scale()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setScale(3, 4)

        lu.assertEquals({tile:getScale()}, {3, 4})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_scale_x()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setScaleX(3)

        lu.assertEquals({tile:getScale()}, {3, 1})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_scale_y()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setScaleY(3)

        lu.assertEquals({tile:getScale()}, {1, 3})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__scale_by()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:scaleBy(3, 4)

        lu.assertEquals({tile:getScale()}, {4, 5})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_origin()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals({tile:getOrigin()}, {0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_origin_x()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getOriginX(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_origin_y()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getOriginY(), 0)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_origin()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setOrigin(10, 20)

        lu.assertEquals({tile:getOrigin()}, {10, 20})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_origin_x()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setOriginX(10)

        lu.assertEquals({tile:getOrigin()}, {10, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_origin_y()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setOriginY(10)

        lu.assertEquals({tile:getOrigin()}, {0, 10})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__draw_coords()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals({tile:getDrawCoords()}, {0, 0, 0, 1, 1, 0, 0})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_dimensions()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals({tile:getDimensions()}, {tile:getImage():getWidth(), tile:getImage():getHeight()})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_width()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile:getWidth(), tile:getImage():getWidth())
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_height()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals(tile:getHeight(), tile:getImage():getHeight())
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_rect()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        local tile = map:getTile(tileset:getFirstGid() + 2)
        lu.assertEquals({tile:getRect()}, {0, 0, 81, 76})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        local tile = map:getTile(tileset:getFirstGid())

        tile:setOffsets(40, 50)

        lu.assertEquals({tile:getOffsets()}, {10, 20})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        local tile = map:getTile(tileset:getFirstGid())

        tile:setOffsetX(40)

        lu.assertEquals({tile:getOffsets()}, {10, 20})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        local tile = map:getTile(tileset:getFirstGid())

        tile:setOffsetY(40)

        lu.assertEquals({tile:getOffsets()}, {10, 20})
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__is_visible()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertIsTrue(tile:isVisible())
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_visibility__true()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setVisibility(true)

        lu.assertIsTrue(tile:isVisible())
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_visibility__false()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setVisibility(false)

        -- Tiles don't have a 'visible' field, so the isVisible() always returns true.
        lu.assertIsTrue(tile:isVisible())
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__get_opacity()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)
        lu.assertEquals(tile:getOpacity(), 1)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_opacity()
        local map = MapFactory(batch_8x8_ortho)
        local tile = map:getTile(1)

        tile:setOpacity(0.1)

        lu.assertEquals(tile:getOpacity(), 1)
    end

    function TestMapMaticTile:test_mapmatic_tile_get_property()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getProperty("tile_prop"), "tile property value")
    end

    function TestMapMaticTile:test_mapmatic_tile_set_property()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())

        tile:setProperty("test_property", "test property value")

        lu.assertEquals(tile:getProperty("test_property"), "test property value")
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__set_num_properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertEquals(tile:getNumProperties(), 2)
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__has_property_key__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsTrue(tile:hasPropertyKey("tileset_prop"))
        lu.assertIsTrue(tile:hasPropertyKey("tile_prop"))
    end

    function TestMapMaticTile:test_mapmatic_tile__tobject__has_property_key__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        local tile = map:getTile(tileset:getFirstGid())
        lu.assertIsFalse(tile:hasPropertyKey("not_a_property"))
    end







