local Player = require "player"


function love.load()
    player = Player.new()


    sti = require "libraries/sti"
    gameMap = sti("maps/map.lua")
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    gameMap:draw()
    player:draw()

end
