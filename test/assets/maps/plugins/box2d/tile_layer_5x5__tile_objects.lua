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
  nextlayerid = 2,
  nextobjectid = 1,
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
                name = "collidable_true",
                type = "",
                shape = "rectangle",
                x = 1,
                y = 2,
                width = 5,
                height = 4,
                rotation = 45,
                visible = true,
                properties = {
                  ["box2d_collidable"] = true
                }
              },
              {
                id = 2,
                name = "collidable_false",
                type = "",
                shape = "rectangle",
                x = 1,
                y = 8,
                width = 5,
                height = 4,
                rotation = 46,
                visible = true,
                properties = {
                  ["box2d_collidable"] = false
                }
              },
              {
                id = 3,
                name = "no_collidable",
                type = "",
                shape = "rectangle",
                x = 8,
                y = 2,
                width = 5.82609,
                height = 3.95652,
                rotation = 45,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 32,
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
                name = "collidable_true",
                type = "",
                shape = "rectangle",
                x = 1,
                y = 2,
                width = 6,
                height = 5,
                rotation = 45,
                visible = true,
                properties = {
                  ["box2d_collidable"] = true
                }
              },
              {
                id = 2,
                name = "collidable_false",
                type = "",
                shape = "rectangle",
                x = 1,
                y = 8,
                width = 6,
                height = 5,
                rotation = 45,
                visible = true,
                properties = {
                  ["box2d_collidable"] = false
                }
              },
              {
                id = 3,
                name = "no_collidable",
                type = "",
                shape = "rectangle",
                x = 9,
                y = 2,
                width = 6,
                height = 5,
                rotation = 45,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 34,
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
                name = "no_collidable",
                type = "",
                shape = "rectangle",
                x = 1.69565,
                y = 2,
                width = 7,
                height = 5.6087,
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
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 5,
      height = 5,
      id = 1,
      name = "tile_layer",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0,
        0, 29, 0, 0, 0,
        0, 0, 35, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0
      }
    }
  }
}
