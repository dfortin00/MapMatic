
local maputils = require("../../../mapmatic/mapfactory/maputils")


TestMapMaticMapUtils = {}

    function TestMapMaticMapUtils:setUp()
        -- Set up a fake map for testing.
        self.tiledmap = {
            orientation = "isometric",
            cache = {},
            width = 8,
            height = 10,
            tilewidth = 128,
            tileheight = 64,
            tiles= {
                [1] = {},
                [2] = {},
                [3] = {x=10, y=20},
                [4] = {},
            },
            offsetx = 0,
            offsety = 0,
        }
    end

    --[[ maputils.buildTransformedTile ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__no_transformation()
        local tile = maputils.buildTransformedTile(self.tiledmap, 2)
        lu.assertEquals(tile.gid, 2)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__map_tile_gid_updated()
        maputils.buildTransformedTile(self.tiledmap, 2)
        lu.assertEquals(self.tiledmap.tiles[2].gid, 2)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally()
        local tile = maputils.buildTransformedTile(self.tiledmap, 0x80000003)
        lu.assertEquals(tile.gid, 0x80000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally__map_tile_created()
        maputils.buildTransformedTile(self.tiledmap, 0x80000003)
        lu.assertEquals(self.tiledmap.tiles[0x80000003].gid, 0x80000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally__map_tile_copied()
        maputils.buildTransformedTile(self.tiledmap, 0x80000003)
        local tile = self.tiledmap.tiles[0x80000003]
        lu.assertEquals({tile.x, tile.y}, {10, 20})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_vertically()
        local tile = maputils.buildTransformedTile(self.tiledmap, 0x40000003)
        lu.assertEquals(tile.gid, 0x40000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_vertically__map_tile_created()
        maputils.buildTransformedTile(self.tiledmap, 0x40000003)
        lu.assertEquals(self.tiledmap.tiles[0x40000003].gid, 0x40000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_vertically__map_tile_copied()
        maputils.buildTransformedTile(self.tiledmap, 0x40000003)
        local tile = self.tiledmap.tiles[0x40000003]
        lu.assertEquals({tile.x, tile.y}, {10, 20})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_diagonally()
        local tile = maputils.buildTransformedTile(self.tiledmap, 0x20000003)
        lu.assertEquals(tile.gid, 0x20000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_diagonally__map_tile_created()
        maputils.buildTransformedTile(self.tiledmap, 0x20000003)
        lu.assertEquals(self.tiledmap.tiles[0x20000003].gid, 0x20000003)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_diagonally__map_tile_copied()
        maputils.buildTransformedTile(self.tiledmap, 0x20000003)
        local tile = self.tiledmap.tiles[0x20000003]
        lu.assertEquals({tile.x, tile.y}, {10, 20})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally_only()
        local gid = 0x80000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {nil, -1, nil})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally_and_vertically_and_diagonally()
        local gid = 0x80000000 + 0x40000000 + 0x20000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {math.rad(-90), nil, -1})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally_and_vertically()
        local gid = 0x80000000 + 0x40000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {nil, -1, -1})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_horizontally_and_diagonally()
        local gid = 0x80000000 + 0x20000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {math.rad(90), nil, nil})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_vertically_only()
        local gid = 0x40000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {nil, nil, -1})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_vertically_and_diagonally()
        local gid = 0x40000000 + 0x20000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {math.rad(-90), nil, nil})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_build_transformed_tile__flip_diagonally_only()
        local gid = 0x20000000 + 3
        maputils.buildTransformedTile(self.tiledmap, gid)
        local tile = self.tiledmap.tiles[gid]
        lu.assertEquals({tile.rotation, tile.sx, tile.sy}, {math.rad(90), nil, -1})
    end

    --[[ maputils.cacheImage ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_cache_image__path()
        local path = "assets/portrait.png"
        maputils.cacheImage(self.tiledmap.cache, path)
        lu.assertNotIsNil(self.tiledmap.cache[path])
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_cache_image__pre_loaded_image()
        local path = "assets/portrait.png"
        local image = love.graphics.newImage(path)
        maputils.cacheImage(self.tiledmap.cache, path, image)
        lu.assertIsTrue(self.tiledmap.cache[path] == image)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_cache_image__image_filter()
        local path = "assets/portrait.png"
        local image = love.graphics.newImage(path)
        maputils.cacheImage(self.tiledmap.cache, path, image)
        lu.assertEquals({self.tiledmap.cache[path]:getFilter()}, {'nearest', 'nearest', 1})
    end

    --[[ maputils.convertIsometricToScreen ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__origin()
        local map = self.tiledmap
        local x, y = maputils.convertIsometricToScreen(self.tiledmap, 0, 0)

        -- The x-coord of the origin is always half the total pixel width of the map.
        lu.assertEquals({x, y}, {map.width * map.tilewidth * 0.5, 0})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__columns()
        local map = self.tiledmap
        local col = 2
        local x, y = maputils.convertIsometricToScreen(self.tiledmap, map.tilewidth * col, 0)
        local origin = map.width * map.tilewidth * 0.5
        lu.assertEquals({x, y}, {origin + map.tilewidth * 0.5 * col, map.tileheight * 0.5 * col})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__rows()
        local map = self.tiledmap
        local row = 2
        local x, y = maputils.convertIsometricToScreen(self.tiledmap, 0, map.tileheight * row)
        local origin = map.width * map.tilewidth * 0.5
        lu.assertEquals({x, y}, {origin - map.tilewidth * 0.5 * row, map.tileheight * 0.5 * row})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__rows_and_columns()
        local map = self.tiledmap
        local col = 3
        local row = 2
        local x, y = maputils.convertIsometricToScreen(self.tiledmap, map.tilewidth * col, map.tileheight * row)
        local origin = map.width * map.tilewidth * 0.5
        lu.assertEquals({x, y}, {(col - row) * (map.tilewidth * 0.5) + origin, (col + row) * (map.tileheight * 0.5)})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__map_offsets()
        local map = self.tiledmap
        map.offsetx = 10
        map.offsety = 20

        local col = 3
        local row = 2
        local x, y = maputils.convertIsometricToScreen(self.tiledmap, map.tilewidth * col, map.tileheight * row)
        local origin = map.width * map.tilewidth * 0.5
        lu.assertEquals({x, y}, {
            (col - row) * (map.tilewidth * 0.5) + origin + 10, (col + row) * (map.tileheight * 0.5) + 20
        })
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_isometric_to_screen__map_not_isometric()
        self.tiledmap.orientation = "orthogonal"
        lu.assertErrorMsgContains("convertIsometricToScreen : map orientation must be 'isometric'",
            maputils.convertIsometricToScreen, self.tiledmap, 0, 0)
    end

    --[[ maputils.convertScreenToIsometric ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__origin()
        local halfMapW = self.tiledmap.width * self.tiledmap.tilewidth * 0.5
        local mapX, mapY = maputils.convertScreenToIsometricTile(self.tiledmap, halfMapW, 0)
        lu.assertEquals({mapX, mapY}, {0, 0})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__columns()
        local tileW = self.tiledmap.tilewidth
        local tileH = self.tiledmap.tileheight
        local halfW = tileW * 0.5
        local halfMapW = self.tiledmap.width * self.tiledmap.tilewidth * 0.5

        local col = 3
        local x = halfMapW + (halfW * col)
        local y = tileH * 0.5 * col

        local mapX, mapY = maputils.convertScreenToIsometric(self.tiledmap, x, y)
        lu.assertEquals({mapX, mapY}, {col * tileW, 0})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__rows()
        local tileW = self.tiledmap.tilewidth
        local tileH = self.tiledmap.tileheight
        local halfW = tileW * 0.5
        local halfH = tileH * 0.5

        local halfMapW = self.tiledmap.width * self.tiledmap.tilewidth * 0.5

        local row = 3
        local x = halfMapW - halfW * row
        local y = halfH * row

        local mapX, mapY = maputils.convertScreenToIsometric(self.tiledmap, x, y)
        lu.assertEquals({mapX, mapY}, {0, row * tileH})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__map_offset()
        local map = self.tiledmap
        map.offsetx = 10
        map.offsety = 20

        local tileW = map.tilewidth
        local tileH = map.tileheight
        local halfW = tileW * 0.5
        local halfH = tileH * 0.5

        local halfMapW = map.width * map.tilewidth * 0.5

        local col = 3
        local row = 2

        -- (half map width) - (half tile width for every row) + (half tile width for every col) + (x offset)
        local x = halfMapW - (halfW * row) + (halfW * col) + 10
        -- (half tile height for every col) + (half tile height for every row) + (y offset)
        local y = (halfH * col) + (halfH * row) + 20

        local mapX, mapY = maputils.convertScreenToIsometric(map, x, y)
        lu.assertEquals({mapX, mapY}, {col * tileW, row * tileH})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__point_inside_tile()
        local map = self.tiledmap
        local tileW = map.tilewidth
        local tileH = map.tileheight

        local halfW = tileW * 0.5
        local halfH = tileH * 0.5
        local halfMapW = map.width * halfW

        local col = 5
        local row = 9

        -- Find the middle of the tile directly to the left of row,col.
        local x = (halfMapW - (halfW * row) + (halfW * col)) - halfW
        local y = ((halfH * col) + (halfH * row))

        local mapX, mapY = maputils.convertScreenToIsometric(map, x, y)
        lu.assertEquals({mapX, mapY}, {(col - 1) * tileW + halfW, row * tileH + halfH})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric__map_not_isometric()
        self.tiledmap.orientation = "orthogonal"
        lu.assertErrorMsgContains("convertScreenToIsometric : map orientation must be 'isometric'",
            maputils.convertScreenToIsometric, self.tiledmap, 0, 0)
    end

    --[[ maputils.convertScreenToIsometricTile ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__origin()
        local halfMapW = self.tiledmap.width * self.tiledmap.tilewidth * 0.5
        local tileCol, tileRow = maputils.convertScreenToIsometricTile(self.tiledmap, halfMapW, 0)
        lu.assertEquals({tileCol, tileRow}, {0, 0})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__columns()
        local tileW = self.tiledmap.tilewidth
        local tileH = self.tiledmap.tileheight

        local halfW = tileW * 0.5
        local halfMapW = self.tiledmap.width * halfW

        local col = 3
        local x = halfW * col + halfMapW
        local y = tileH * 0.5 * col

        local tileCol, tileRow = maputils.convertScreenToIsometricTile(self.tiledmap, x, y)

        lu.assertEquals({tileCol, tileRow}, {3, 0})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__rows()
        local tileW = self.tiledmap.tilewidth
        local tileH = self.tiledmap.tileheight

        local halfW = tileW * 0.5
        local halfH = tileH * 0.5
        local halfMapW = self.tiledmap.width * halfW

        local row = 3
        local x = halfMapW - halfW * row
        local y = halfH * row

        local tileCol, tileRow = maputils.convertScreenToIsometricTile(self.tiledmap, x, y)

        lu.assertEquals({tileCol, tileRow}, {0, 3})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__map_offsets()
        local map = self.tiledmap
        map.offsetx = 10
        map.offsety = 20

        local tileW = map.tilewidth
        local tileH = map.tileheight

        local halfW = tileW * 0.5
        local halfH = tileH * 0.5
        local halfMapW = map.width * halfW

        local col = 3
        local row = 2

        -- (half map width) - (half tile width for every row) + (half tile width for every col) + (x offset)
        local x = halfMapW - (halfW * row) + (halfW * col) + 10
        -- (half tile height for every col) + (half tile height for every row) + (y offset)
        local y = (halfH * col) + (halfH * row) + 20

        local tileCol, tileRow = maputils.convertScreenToIsometricTile(map, x, y)

        lu.assertEquals({tileCol, tileRow}, {3, 2})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__point_inside_tile()
        local map = self.tiledmap
        local tileW = map.tilewidth
        local tileH = map.tileheight

        local halfW = tileW * 0.5
        local halfH = tileH * 0.5
        local halfMapW = map.width * halfW

        local col = 5
        local row = 9

        -- Find tile location and step back one pixel into adjacent tile.
        local x = (halfMapW - (halfW * row) + (halfW * col)) - 1
        local y = ((halfH * col) + (halfH * row)) - 1

        local tileCol, tileRow = maputils.convertScreenToIsometricTile(map, x, y)

        lu.assertEquals({tileCol, tileRow}, {4, 8})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_screen_to_isometric_tile__map_not_isometric()
        self.tiledmap.orientation = "orthogonal"
        lu.assertErrorMsgContains("convertScreenToIsometricTile : map orientation must be 'isometric'",
            maputils.convertScreenToIsometricTile, self.tiledmap, 0, 0)
    end

    --[[ maputils.convertEllipseToPolygon ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_ellipse_to_polygon__default_num_segments()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40)

        -- Default numSegments is 64 vertices. The list should contain 66 vertex points. The first vertex
        -- in list is center point of ellipse. There is one additional vertex added to end of list to close
        -- the polygon loop at the starting point.
        lu.assertEquals(#vertices, 1 + 64 + 1)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_ellipse_to_polygon__num_segments()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40, 30)
        lu.assertEquals(#vertices, 1 + 30 + 1)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_ellipse_to_polygon__first_vertex_is_center_point()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40, 30)
        lu.assertEquals(vertices[1], {x=10 + 30 * 0.5, y=20 + 40 * 0.5})
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_convert_ellipse_to_polygon__last_vertex_equals_starting_vertex()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40, 64)
        lu.assertAlmostEquals(vertices[2].x, vertices[#vertices].x, 0.0001)
        lu.assertAlmostEquals(vertices[2].y, vertices[#vertices].y, 0.0001)
    end

    --[[ maputils.flattenVertexTable ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_flatten_vertex_table()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40)
        local numvertices = #vertices
        local vertices = maputils.flattenVertexTable(vertices)
        lu.assertEquals(#vertices, numvertices * 2)
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_flatten_vertex_table__points()
        local vertices = maputils.convertEllipseToPolygon(10, 20, 30, 40)
        local v = maputils.flattenVertexTable(vertices)
        lu.assertEquals({v[1], v[2]}, {vertices[1].x, vertices[1].y})
    end

    --[[ maputils.getDecompressedData ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_get_decompressed_data__base64()
        local data = "AQAAAAEAAAABAAAAAQAAAAIAAAACAAAAAgAAAAIAAAADAAAAAwAAAAMAAAADAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAA="
        local mapdata = maputils.getDecompressedData(data, nil, 4, 5)
        lu.assertEquals(mapdata, {
            1, 1, 1, 1,
            2, 2, 2, 2,
            3, 3, 3, 3,
            4, 4, 4, 4,
            5, 5, 5, 5,
        })
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_get_decompressed_data__gzip()
        local data = "H4sIAAAAAAAACmNkYGBgRMJMaJgZDbOgYVY0DABHGooPUAAAAA=="
        local mapdata = maputils.getDecompressedData(data, 'gzip', 4, 5)
        lu.assertEquals(mapdata, {
            1, 1, 1, 1,
            2, 2, 2, 2,
            3, 3, 3, 3,
            4, 4, 4, 4,
            5, 5, 5, 5,
        })
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_get_decompressed_data__zlib()
        local data = "eJxjZGBgYETCTGiYGQ2zoGFWNAwAB6gAPQ=="
        local mapdata = maputils.getDecompressedData(data, 'zlib', 4, 5)
        lu.assertEquals(mapdata, {
            1, 1, 1, 1,
            2, 2, 2, 2,
            3, 3, 3, 3,
            4, 4, 4, 4,
            5, 5, 5, 5,
        })
    end

    function TestMapMaticMapUtils:test_mapmatic_map_utils_get_decompressed_data__no_width_and_height_specified()
        local data = "AQAAAAEAAAABAAAAAQAAAAIAAAACAAAAAgAAAAIAAAADAAAAAwAAAAMAAAADAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAA="
        local mapdata = maputils.getDecompressedData(data)
        lu.assertEquals(#mapdata, 5 * 4 + 1)
    end

    --[[ maputils.loadImage ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_load_image()
        -- Not much to test with this function. Just make sure it's called at least once in the test suite.
        local t = {transparentcolor = "#FF00FF"}
        maputils.loadImage(t, "assets/portrait.png")
        lu.assertEquals(t.image:type(), "Image")
    end

    --[[ maputils.rotateVertex ]]

    function TestMapMaticMapUtils:test_mapmatic_map_utils_rotate_vertex()
        local deg = -90
        local rotation = math.rad(deg)
        local cos = math.cos(rotation)
        local sin = math.sin(rotation)

        local vertex = {x=16, y=16}

        self.tiledmap.orientation = "orthogonal"
        vertex = maputils.rotateVertex(self.tiledmap, vertex, 16, 32, cos, sin)

        lu.assertEquals(vertex, {x=0, y=32})
    end







