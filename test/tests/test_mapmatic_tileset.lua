
local utils = require("../../../mapmatic/utils")

local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho = mapdir .. 'batch_8x8_ortho__ts1_tc1'

TestMapMaticTileSet = {}

    function TestMapMaticTileSet:test_mapmatic_tile_set__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertEquals(tileset:type(), "TileSet")
    end

    --[[ TileSet:init ]]

    --======
    -- Index
    --======

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__tileset_index()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertIsTrue(map.tilesets[tileset.index] == tileset)
    end

    --=======
    -- Images
    --=======

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertNotIsNil(tileset.image)
        lu.assertEquals(tileset.image:type(), "Image")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__tileset_image_type()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals(tileset.imagetype, "atlas")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsNil(tileset.image)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__tile_collection__image_type()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset.imagetype, "collection")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__cache__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertIsTrue(map.factory.__cache["assets/world_tileset.png"] == tileset.image)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__cache__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsTrue(map.factory.__cache["assets/back.png"] == tileset.tiles[tileset.firstgid].image)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__image__cache__multiple_tilesets_use_same_image()
        local map = MapFactory(batch_8x8_ortho)
        local tileset16 = map:getTileSet("world_tileset16x16")
        local tileset32 = map:getTileSet("world_tileset32x32")
        lu.assertIsTrue(tileset16.image == tileset32.image)
    end

    --==========
    -- Tile List
    --==========

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__tile_list__gids()
        local map = MapFactory(batch_8x8_ortho)

        for index, tileset in ipairs(map.tilesets) do
            local firstgid = tileset.firstgid
            local nextgid = map.tilesets[index + 1] and
                map.tilesets[index + 1].firstgid or
                (firstgid + utils.table.getn(tileset.tiles))

            for index in pairs(tileset.tiles) do
                lu.assertIsTrue((index < nextgid) and (index >= firstgid))
            end
        end
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__tile_list__type()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertEquals(tileset.tiles[1]:type(), "Tile")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_init__tile_list__map()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertIsTrue(tileset.tiles[1] == map.tiles[1])
    end

    ----------------------------------------------------

    --[[ TileSet:getName ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_name()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals(tileset:getName(), "world_tileset16x16")
    end

    --[[ TileSet:getFirstGid ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_first_gid()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals(tileset:getFirstGid(), 1)
    end

    --[[ TileSet:getIndex ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_index()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertEquals(tileset:getIndex(), 1)
    end

    --[[ TileSet:getTile ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile__tile_part_of_tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertNotIsNil(tileset:getTile(1))
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile__tile_outside_tileset_scope()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertIsNil(tileset:getTile(65))
        lu.assertNotIsNil(map.tiles[65])
    end

    --[[ TileSet:getTiles ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tiles()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet(1)
        lu.assertIsTrue(tileset:getTiles() == tileset.tiles)
    end

    --[[ TileSet:getTileWidth ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_width__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset32x32")
        lu.assertEquals(tileset:getTileWidth(), 32)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_width__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")

        local maxwidth = 0
        for _, tile in pairs(tileset.tiles) do
            maxwidth = math.max(tile.width, maxwidth)
        end

        lu.assertEquals(tileset:getTileWidth(), maxwidth)
    end

    --[[ TileSet:getTileHeight ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_height__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset32x32")
        lu.assertEquals(tileset:getTileHeight(), 32)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_height__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")

        local maxheight = 0
        for _, tile in pairs(tileset.tiles) do
            maxheight = math.max(tile.height, maxheight)
        end

        lu.assertEquals(tileset:getTileHeight(), maxheight)
    end

    --[[ TileSet:getNumRows ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_num_rows__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getNumRows(), 6)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_num_rows__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset:getNumRows(), utils.table.getn(tileset.tiles))
    end

    --[[ TileSet:getNumCols ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_num_cols__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getNumCols(), 8)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_num_cols__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset:getNumCols(), 1)
    end

    --[[ TileSet:getTileCount ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_count__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getTileCount(), 8 * 6)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_tile_count__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset:getTileCount(), 6)
    end

    --[[ TileSet:isAtlas ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_is_atlas__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertIsTrue(tileset:isAtlas())
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_is_atlas__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsFalse(tileset:isAtlas())
    end

    --[[ TileSet:getImage ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        local img = map.factory.__cache["assets/tmw_desert_spacing.png"]
        lu.assertIsTrue(tileset:getImage() == img)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsNil(tileset:getImage())
    end

    --[[ TileSet:getImageType ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_type__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getImageType(), "atlas")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_type__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset:getImageType(), "collection")
    end

    --[[ TileSet:getImageDimensions ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_dimensions__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals({tileset:getImageDimensions()}, {128, 128})
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_dimensions__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertEquals(tileset:getImageDimensions())
    end

    --[[ TileSet:getImageWidth ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_width__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals(tileset:getImageWidth(), 128)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_width__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsNil(tileset:getImageWidth())
    end

    --[[ TileSet:getImageHeight ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_height__tileset()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")
        lu.assertEquals(tileset:getImageHeight(), 128)
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_image_height__tile_collection()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tile_collection")
        lu.assertIsNil(tileset:getImageHeight())
    end

    --[[ TileSet:getMargin ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_margin()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getMargin(), 1)
    end

    --[[ TileSet:getSpacing ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_spacing()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getSpacing(), 1)
    end

    --[[ TileSet:getOffsets ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals({tileset:getOffsets()}, {10, 20})
    end

    --[[ TileSet:getOffsetX ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getOffsetX(), 10)
    end

    --[[ TileSet:getOffsetY ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset:getOffsetY(), 20)
    end

    --[[ TileSet:setOffsets ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offsets()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("world_tileset16x16")

        tileset:setOffsets(20, 40)

        lu.assertEquals({tileset.tileoffset.x, tileset.tileoffset.y}, {20, 40})
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offsets__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertErrorMsgContains("setOffsets : param #1 must be a number type", tileset.setOffsets, tileset, "")
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offsets__param2_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertErrorMsgContains("setOffsets : param #2 must be a number type", tileset.setOffsets, tileset, 0, "")
    end

    --[[ TileSet:setOffsetX ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offset_x()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")

        tileset:setOffsetX(50)

        lu.assertEquals({tileset.tileoffset.x, tileset.tileoffset.y}, {50, 20})
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offset_x__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertErrorMsgContains("setOffsetX : param #1 must be a number type", tileset.setOffsetX, tileset, "")
    end

    --[[ TileSet:setOffsetY ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offset_y()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")

        tileset:setOffsetY(50)

        lu.assertEquals({tileset.tileoffset.x, tileset.tileoffset.y}, {10, 50})
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_offset_y__param1_not_number()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertErrorMsgContains("setOffsetY : param #1 must be a number type", tileset.setOffsetY, tileset, "")
    end

    --[[ TileSet:getProperty ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_property()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertEquals(tileset.properties:type(), "MapProperties")
        lu.assertEquals(tileset:getProperty("tileset_property"), "tileset property value")
    end

    --[[ TileSet:setProperty ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_set_property()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        tileset:setProperty("test_property", "test value")
        lu.assertEquals(tileset.properties:get("test_property"), "test value")
    end

    --[[ TileSet:getNumProperties ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_get_num_properties()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        tileset:setProperty("test_property", "test value")
        lu.assertEquals(tileset:getNumProperties(), 2)
    end

    --[[ TileSet:hasPropertyKey ]]

    function TestMapMaticTileSet:test_mapmatic_tile_set_has_property_key__true()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertIsTrue(tileset:hasPropertyKey("tileset_property"))
    end

    function TestMapMaticTileSet:test_mapmatic_tile_set_has_property_key__false()
        local map = MapFactory(batch_8x8_ortho)
        local tileset = map:getTileSet("tmw_desert_spacing")
        lu.assertIsFalse(tileset:hasPropertyKey("not_a_property"))
    end



















