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
  nextobjectid = 1,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../bkgrnd.png",
      id = 2,
      name = "image_layer__collidable=true",
      visible = true,
      opacity = 1,
      offsetx = 10,
      offsety = 20,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {
        ["box2d_collidable"] = true
      }
    },
    {
      type = "imagelayer",
      image = "../../../bkgrnd.png",
      id = 3,
      name = "image_layer__collidable=false",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {
        ["box2d_collidable"] = false
      }
    },
    {
      type = "imagelayer",
      image = "../../../bkgrnd.png",
      id = 4,
      name = "image_layer__no_collidable_flag",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    }
  }
}
