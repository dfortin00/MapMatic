return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 7,
  nextobjectid = 44,
  properties = {},
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
      properties = {},
      wangsets = {},
      tilecount = 64,
      tiles = {
        {
          id = 0,
          objectGroup = {
            type = "objectgroup",
            draworder = "index",
            id = 2,
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            parallaxx = 1,
            parallaxy = 1,
            properties = {},
            objects = {
              {
                id = 1,
                name = "tile_object",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 0,
                width = 16,
                height = 16,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 33,
          animation = {
            {
              tileid = 33,
              duration = 500
            },
            {
              tileid = 57,
              duration = 500
            }
          }
        }
      }
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "object_layer_1",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "object_1",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "object_2",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "index",
      id = 3,
      name = "object_layer_2",
      visible = false,
      opacity = 1,
      offsetx = 10,
      offsety = 20,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "object_3",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "object_4",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "elli",
          type = "",
          shape = "ellipse",
          x = 80,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "poly",
          type = "",
          shape = "polygon",
          x = 32,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 16 },
            { x = 16, y = 32 },
            { x = 16, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          id = 41,
          name = "pline",
          type = "",
          shape = "polyline",
          x = 64,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 16 }
          },
          properties = {}
        },
        {
          id = 42,
          name = "p",
          type = "",
          shape = "point",
          x = 96,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "tileobject",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 1,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "object_layer_3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["layer_prop"] = "test layer value"
      },
      objects = {
        {
          id = 8,
          name = "rect",
          type = "TestType",
          shape = "rectangle",
          x = 0,
          y = 64,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["extra_prop"] = "test value",
            ["test_prop"] = "default_value"
          }
        },
        {
          id = 9,
          name = "rect_w_rotation",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 64,
          width = 22.6274,
          height = 22.6274,
          rotation = 45,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "poly",
          type = "",
          shape = "polygon",
          x = 64,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -16, y = 16 },
            { x = 0, y = 32 },
            { x = 0, y = 48 },
            { x = 16, y = 48 },
            { x = 16, y = 32 },
            { x = 32, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 12,
          name = "elli",
          type = "",
          shape = "ellipse",
          x = 64,
          y = 80,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "elli_w_rotation",
          type = "",
          shape = "ellipse",
          x = 112,
          y = 80,
          width = 16,
          height = 32,
          rotation = 90,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "poly_w_rotation",
          type = "",
          shape = "polygon",
          x = 128,
          y = 16,
          width = 0,
          height = 0,
          rotation = 45,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -16, y = 16 },
            { x = 0, y = 32 },
            { x = 0, y = 48 },
            { x = 16, y = 48 },
            { x = 16, y = 32 },
            { x = 32, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 20,
          name = "p",
          type = "",
          shape = "point",
          x = 128,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "pline",
          type = "",
          shape = "polyline",
          x = 16,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 16 },
            { x = 32, y = 0 },
            { x = 48, y = 16 }
          },
          properties = {}
        },
        {
          id = 23,
          name = "pline_w_rotation",
          type = "",
          shape = "polyline",
          x = 96,
          y = 112,
          width = 0,
          height = 0,
          rotation = 90,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 16 },
            { x = 32, y = 0 },
            { x = 48, y = 16 }
          },
          properties = {}
        },
        {
          id = 24,
          name = "tileobject1",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 144,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 34,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "tileobject2",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 144,
          width = 16,
          height = 16,
          rotation = 45,
          gid = 3221225506,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "tile_no_anim",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 160,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 8,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "object_layer_4",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 27,
          name = "objectname",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "notobjectname",
          type = "",
          shape = "point",
          x = 48,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "objectname",
          type = "",
          shape = "ellipse",
          x = 80,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "objectname",
          type = "",
          shape = "polygon",
          x = 112,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 16 },
            { x = 32, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "objectname",
          type = "",
          shape = "polyline",
          x = 16,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = 0 }
          },
          properties = {}
        },
        {
          id = 32,
          name = "objectname",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 24,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "notobjectname",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 24,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "rect_invisible",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 80,
          width = 16,
          height = 32,
          rotation = 0,
          visible = false,
          properties = {}
        },
        {
          id = 35,
          name = "rect_visible",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 80,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "object_layer_5",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
