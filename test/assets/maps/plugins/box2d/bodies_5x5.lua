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
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = false,
            ["box2d_kinematic"] = false,
            ["box2d_static"] = false
          }
        },
        {
          id = 29,
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = true,
            ["box2d_kinematic"] = false,
            ["box2d_static"] = false
          }
        },
        {
          id = 30,
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = false,
            ["box2d_kinematic"] = true,
            ["box2d_static"] = false
          }
        },
        {
          id = 31,
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = false,
            ["box2d_kinematic"] = false,
            ["box2d_static"] = true
          }
        },
        {
          id = 32,
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = true,
            ["box2d_kinematic"] = true,
            ["box2d_static"] = true
          }
        },
        {
          id = 33,
          properties = {
            ["box2d_collidable"] = true,
            ["box2d_dynamic"] = false,
            ["box2d_kinematic"] = true,
            ["box2d_static"] = true
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
                name = "",
                type = "",
                shape = "ellipse",
                x = 0,
                y = 0,
                width = 16,
                height = 16,
                rotation = 0,
                visible = true,
                properties = {
                  ["box2d_collidable"] = true,
                  ["box2d_dynamic"] = true,
                  ["box2d_kinematic"] = false,
                  ["box2d_static"] = false
                }
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
        29, 30, 31, 32, 33,
        34, 35, 0, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0
      }
    }
  }
}
