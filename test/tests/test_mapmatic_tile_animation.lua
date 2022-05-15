
local mapdir = 'assets/maps/orthogonal/'

local batch_8x8_ortho = mapdir .. 'batch_8x8_ortho__ts1_tc1'

-- Helper function to retrieve an animation from a tile.
local function _get_animation(map, tsname, offset)
    offset = offset or 0
    local tileset = map:getTileSet(tsname)
    local tile = map:getTile(tileset:getFirstGid() + offset)
    return tile:getAnimation()
end

TestMapMaticTileAnimation = {}

    function TestMapMaticTileAnimation:tearDown()
        MapFactory:clearCache()
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation__class_name()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "tile_collection", 1)
        lu.assertEquals(anim:type(), "TileAnimation")
    end

    --[[ TileAnimation:init ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__frame_index()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim.frame, 1)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__timer()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim.timer, 0)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__speed_factor()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim.speedfactor, 1)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__looping()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertIsTrue(anim.looping)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__playing()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertIsTrue(anim.playing)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__frames()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(#anim, 2)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_init__frames__gid()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim[1].gid, 2)
    end

    --[[ TileAnimation:getCurrentFrame ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_get_current_frame()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim:getCurrentFrame(), {
            tileid   = 1,
            gid      = 2,
            duration = 500,
        })
    end

    --[[ TileAnimation:setCurrentFrame ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_current_frame()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setCurrentFrame(2)
        lu.assertEquals(anim:getCurrentFrame(), {
            tileid   = 33,
            gid      = 34,
            duration = 500,
        })
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_current_frame__less_than_1()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setCurrentFrame(0)
        lu.assertEquals(anim:getCurrentFrame(), {
            tileid   = 1,
            gid      = 2,
            duration = 500,
        })
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_current_frame__greater_than_max_frames()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setCurrentFrame(#anim + 1)
        lu.assertEquals(anim:getCurrentFrame(), {
            tileid   = 33,
            gid      = 34,
            duration = 500,
        })
    end

    --[[ TileAnimation:getNumFrames ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_get_num_frames()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim:getNumFrames(), 2)
    end

    --[[ TileAnimation:getCurrentGid ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_get_current_gid()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim:getCurrentGid(), 2)
    end

    --[[ TileAnimation:getSpeedFactor ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_get_speed_factor()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertEquals(anim:getSpeedFactor(), 1)
    end

    --[[ TileAnimation:setSpeedFactor ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_speed_factor()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setSpeedFactor(2)
        lu.assertEquals(anim:getSpeedFactor(), 2)
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_speed_factor__less_than_zero()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setSpeedFactor(-1)
        lu.assertEquals(anim:getSpeedFactor(), 0)
    end

    --[[ TileAnimation:isLooping ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_is_looping__true()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertIsTrue(anim:isLooping())
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_is_looping__false()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim.looping = false
        lu.assertIsFalse(anim:isLooping())
    end

    --[[ TileAnimation:setLooping ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_set_looping()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim:setLooping(false)
        lu.assertIsFalse(anim:isLooping())
    end

    --[[ TileAnimation:isPlaying ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_is_playing__true()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        lu.assertIsTrue(anim:isPlaying())
    end

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_is_playing__false()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)
        anim.playing = false
        lu.assertIsFalse(anim:isPlaying())
    end

    --[[ TileAnimation:play ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_play()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)

        anim:update(0.51)
        anim:play()

        lu.assertEquals({anim.playing, anim.frame}, {true, 2})
    end

    --[[ TileAnimation:pause ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_pause()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)

        anim:play()
        anim:update(0.51)
        anim:pause()

        lu.assertEquals({anim.playing, anim.frame}, {false, 2})
    end

    --[[ TileAnimation:stop ]]

    function TestMapMaticTileAnimation:test_mapmatic_tile_animation_stop()
        local map = MapFactory(batch_8x8_ortho)
        local anim = _get_animation(map, "world_tileset16x16", 1)

        anim:update(0.51)
        anim:stop()

        lu.assertEquals({anim.playing, anim.frame}, {false, 1})
    end


















