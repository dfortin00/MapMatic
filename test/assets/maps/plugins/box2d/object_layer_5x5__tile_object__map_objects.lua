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
  nextlayerid = 3,
  nextobjectid = 2,
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
      tiles = {
        {
          id = 28,
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
                name = "",
                type = "",
                shape = "rectangle",
                x = 1,
                y = 2,
                width = 5,
                height = 6,
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
                x = 8,
                y = 3,
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
                x = 10,
                y = 4,
                width = 5,
                height = 4,
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
                x = 1,
                y = 10,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polyline = {
                  { x = 0, y = 0 },
                  { x = 4.5, y = 0.09375 }
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
                x = 7,
                y = 12,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polyline = {
                  { x = 0, y = 0 },
                  { x = -0.0625, y = -3.09375 },
                  { x = 3.46875, y = -3.0625 }
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
                x = 12,
                y = 9,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = -0.03125, y = 5.75 },
                  { x = 3.875, y = 5.75 },
                  { x = 3.5, y = 2.46875 }
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
                y = 0,
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
    }
  },
  layers = {
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
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 32,
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
