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
  nextlayerid = 5,
  nextobjectid = 23,
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
      id = 2,
      name = "object_layer__objects_collidable=true",
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "point",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "ellipse",
          x = 48,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 },
            { x = 16, y = 16 }
          },
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 6,
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
            { x = 16, y = 32 },
            { x = 16, y = 16 }
          },
          properties = {
            ["box2d_collidable"] = true
          }
        },
        {
          id = 7,
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
          properties = {
            ["box2d_collidable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "object_layer__objects_collidable=false",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "point",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "ellipse",
          x = 48,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 },
            { x = 16, y = 16 }
          },
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 21,
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
            { x = 16, y = 32 },
            { x = 16, y = 16 },
            { x = 0, y = 0 }
          },
          properties = {
            ["box2d_collidable"] = false
          }
        },
        {
          id = 22,
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
          properties = {
            ["box2d_collidable"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "object_layer__objects_are_not_collidable",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 9,
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
          id = 10,
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
          id = 11,
          name = "",
          type = "",
          shape = "ellipse",
          x = 48,
          y = 0,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "polyline",
          x = 0,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "polyline",
          x = 32,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 },
            { x = 16, y = 16 }
          },
          properties = {}
        },
        {
          id = 14,
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
            { x = 16, y = 32 },
            { x = 16, y = 16 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          id = 15,
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
