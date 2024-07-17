require "player"



function love.load()
    playerSprite()
    sti = require "libraries/sti"
    gameMap = sti("maps/map.lua")
    -- Background setup
    background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
    playerMovement(dt)
end

function love.draw()
    gameMap:draw()
    -- love.graphics.draw(background, 0, 0)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5)
end
