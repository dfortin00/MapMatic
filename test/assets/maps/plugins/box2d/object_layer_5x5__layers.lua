return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 5,
  height = 5,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 10,
  nextobjectid = 55,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 14,
      image = "../../../tiles.png",
      imagewidth = 224,
      imageheight = 64,
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
      tilecount = 56,
      tiles = {}
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "index",
      id = 7,
      name = "object_layer__collidable=true",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["box2d_collidable"] = true
      },
      objects = {
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 17,
          rotation = 45,
          visible = true,
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "point",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "ellipse",
          x = 64,
          y = 0,
          width = 16,
          height = 17,
          rotation = 45,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 48,
          width = 0,
          height = 0,
          rotation = 45,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = -16 }
          },
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 48,
          width = 0,
          height = 0,
          rotation = 45,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = -16 },
            { x = 16, y = -16 }
          },
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "polygon",
          x = 64,
          y = 32,
          width = 0,
          height = 0,
          rotation = 45,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 32 },
            { x = 16, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 16,
          height = 16,
          rotation = 45,
          gid = 29,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "object_layer__collidable=false",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["box2d_collidable"] = false
      },
      objects = {
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "point",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "ellipse",
          x = 64,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = -16 }
          },
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = -16 },
            { x = 16, y = -16 }
          },
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "polygon",
          x = 64,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 32 },
            { x = 16, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 29,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "object_layer__no_collidable",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "point",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "ellipse",
          x = 64,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = -16 }
          },
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = -16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "polygon",
          x = 64,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 32 },
            { x = 16, y = 16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 29,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
