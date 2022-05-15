return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.6.0",
  orientation = "orthogonal",
  renderorder = "right-up",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 2,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "world_tileset_16x16",
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
      tiles = {}
    },
    {
      name = "tmw_desert_spacing",
      firstgid = 65,
      tilewidth = 32,
      tileheight = 32,
      spacing = 1,
      margin = 1,
      columns = 8,
      image = "../../tmw_desert_spacing.png",
      imagewidth = 265,
      imageheight = 199,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 48,
      tiles = {}
    },
    {
      name = "collection",
      firstgid = 113,
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
      properties = {},
      wangsets = {},
      tilecount = 4,
      tiles = {
        {
          id = 0,
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
          image = "../../mage_portrait.png",
          width = 81,
          height = 76
        },
        {
          id = 3,
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
      properties = {},
      encoding = "lua",
      data = {
        65, 24, 24, 24, 24, 24, 24, 24, 24, 79,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 116, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 115, 24, 24, 24, 24, 24,
        24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
        84, 24, 24, 24, 24, 24, 24, 24, 24, 112
      }
    }
  }
}
