
local mapdir = 'assets/maps/orthogonal/'

local empty_map        = mapdir .. 'empty_8x8_ortho'
local simple_map       = mapdir .. 'simple_8x8_ortho_ts1'
local layers_8x8_ortho = mapdir .. 'layers_8x8_ortho'

TestMapMaticInit = {}

    function TestMapMaticInit:tearDown()
        MapFactory:clearCache()
    end

    --[[ MapFactory ]]

    function TestMapMaticInit:test_mapmatic_init_map_factory__name()
        lu.assertEquals(MapFactory:name(), "MapMatic")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__version()
        lu.assertEquals(MapFactory:version(), "0.1.0")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__license()
        lu.assertEquals(MapFactory:license(), "MIT/X11")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__description()
        lu.assertEquals(MapFactory:description(),
            "A LOVE2D library for rendering and controlling tile maps created with the Tiled application")
    end

    --[[ New Map ]]

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__no_extension()
        local map = MapFactory(empty_map)
        lu.assertEquals(map:type(), "Map")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__map_factory_cache()
        MapFactory(simple_map)
        lu.assertNotNil(MapFactory.__cache['assets/world_tileset.png'])
        lu.assertEquals(MapFactory.__cache['assets/world_tileset.png']:type(), "Image")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__with_extension()
        local map = MapFactory(empty_map)
        lu.assertEquals(map:type(), "Map")
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__map_gets_reference_to_factory()
        local map = MapFactory(empty_map)
        lu.assertNotIsNil(map.factory == MapFactory)
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__invalid_extension()
        lu.assertErrorMsgContains("Invalid map file : File must be of type .lua : assets/maps/empty_8x8_orth.lll",
            MapFactory.__call, MapFactory, 'assets/maps/empty_8x8_orth.lll')
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__invalid_location()
        lu.assertErrorMsgContains("Invalid map file : File does not exist : maps/nosuchmap",
            MapFactory.__call, MapFactory, 'maps/nosuchmap')
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__param2_not_table()
        lu.assertErrorMsgContains("init: param #2 is not a table type : actual (boolean)",
            MapFactory.__call, MapFactory, empty_map, true)
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__config__offset_x__not_number()
        lu.assertErrorMsgContains("init: 'config.offsetx' is not a number type : actual (string)",
            MapFactory.__call, MapFactory, empty_map, {offsetx=""})
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory__new_map__config__offset_y__not_number()
        lu.assertErrorMsgContains("init: 'config.offsety' is not a number type : actual (string)",
            MapFactory.__call, MapFactory, empty_map, {offsety=""})
    end

    --[[ Cache ]]

    --==========
    -- Get Cache
    --==========

    function TestMapMaticInit:test_mapmatic_init_map_factory_get_cache()
        local cache = MapFactory:getCache()
        lu.assertIsTrue(cache == MapFactory.__cache)
    end

    function TestMapMaticInit:test_mapmatic_init_map_factory_get_cache_item()
        MapFactory(simple_map)
        local item = MapFactory:getCacheItem("assets/world_tileset.png")
        lu.assertIsTrue(item == MapFactory.__cache["assets/world_tileset.png"])
    end

    --============
    -- Clear Cache
    --============

    function TestMapMaticInit:test_mapmatic_init_map_factory_clear_cache()
        MapFactory(simple_map)

        lu.assertNotNil(MapFactory.__cache['assets/world_tileset.png'])
        MapFactory:clearCache()
        lu.assertNil(MapFactory.__cache['assets/world_tileset.png'])
    end



















