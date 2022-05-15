return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 7,
  properties = {
    ["map_bool_prop"] = false,
    ["map_color_prop"] = "#ff55ff00",
    ["map_file_prop"] = "../../mage_portrait.png",
    ["map_float_prop"] = 1.4,
    ["map_int_prop"] = 2,
    ["map_object_prop"] = { id = 1 },
    ["map_string_prop"] = "map string value"
  },
  tilesets = {
    {
      name = "world_tileset",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../../world_tileset.png",
      imagewidth = 128,
      imageheight = 128,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {
        ["tileset_prop"] = "tileset value"
      },
      wangsets = {},
      tilecount = 64,
      tiles = {
        {
          id = 0,
          properties = {
            ["ts_tile_prop"] = "tileset tile value"
          }
        }
      }
    },
    {
      name = "collection_ts",
      firstgid = 65,
      tilewidth = 81,
      tileheight = 76,
      spacing = 0,
      margin = 0,
      columns = 0,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {
        ["tile_collection_prop"] = "tile collection value"
      },
      wangsets = {},
      tilecount = 3,
      tiles = {
        {
          id = 0,
          properties = {
            ["tc_tile_prop"] = "tile collection tile value"
          },
          image = "../../back.png",
          width = 16,
          height = 16
        },
        {
          id = 1,
          image = "../../bpanel.png",
          width = 15,
          height = 15
        },
        {
          id = 2,
          image = "../../portrait.png",
          width = 81,
          height = 76
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 1,
      name = "tile_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["tile_layer_prop"] = "tile layer value"
      },
      encoding = "lua",
      data = {
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "object_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["object_layer_prop"] = "object layer value"
      },
      objects = {
        {
          id = 1,
          name = "cave_object",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 47,
          visible = true,
          properties = {
            ["tile_object_prop"] = "tile object value"
          }
        },
        {
          id = 2,
          name = "rect",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["rect_object_prop"] = "rectangle object value"
          }
        },
        {
          id = 3,
          name = "point",
          type = "",
          shape = "point",
          x = 80,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["point_object_prop"] = "point object value"
          }
        },
        {
          id = 4,
          name = "ellipse",
          type = "",
          shape = "ellipse",
          x = 112,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["ellipse_object_prop"] = "ellipse object value"
          }
        },
        {
          id = 5,
          name = "polygon",
          type = "",
          shape = "polygon",
          x = 144,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -16 },
            { x = 16, y = -16 }
          },
          properties = {
            ["polygon_object_prop"] = "polygon object value"
          }
        },
        {
          id = 6,
          name = "polyline",
          type = "",
          shape = "polyline",
          x = 96,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 16 }
          },
          properties = {
            ["polyline_object_prop"] = "polyline object value"
          }
        }
      }
    },
    {
      type = "imagelayer",
      image = "",
      id = 3,
      name = "image_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {
        ["image_layer_prop"] = "image layer value"
      }
    },
    {
      type = "group",
      id = 4,
      name = "group_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["group_layer_prop"] = "group layer value"
      },
      layers = {}
    }
  }
}
