# MapMatic
MapMatic is a [LOVE2D](https://love2d.org/) library for importing tiled maps created with the [Tiled](https://www.mapeditor.org/) map editor.

## Basic Setup
```
local MapFactory = require("mapmatic")
local map = MapFactory("maps/tiled_map.lua") -- The .lua extension for the filename is optional.
```
Tiled maps must be exported into the project as a .LUA file.

## Example
```
local MapFactory = require("mapmatic")
local map
local mapx
local world

function love.load()
    map = MapFactory("maps/small_map")
    map:resize(640, 480)

    map:getLayer("collisions"):setVisibility(false)
    map:getLayer("backgrounds.background"):setRepeatX(true)

    -- Requires the Box2D plugin in the mapmatic/plugins folder
    world = love.phyics.newWorld(0, 0)
    map:loadPlugin("Box2D", world)

    mapx = 0
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        mapx = mapx - 0.5
    elseif love.keyboard.isDown("right") then
        mapx = mapx + 0.5
    end

    if mapx < 0 then mapx = 0 end
    if mapx > (map:getMapWidth() - 640) then
        mapx = map:getMapWidth() - 640
    end

    world:update(dt)
    map:update(dt)
end

function love.draw()
    -- Parameters: tx, ty, sx, sy
    map:render(mapx, 0, 2, 2)
end

```


