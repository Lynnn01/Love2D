function love.load()
    anim8 = require "libraries/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 400
    player.y = 200
    player.speed = 5
    player.framerate = 0.1
    player.sprite = love.graphics.newImage("sprites/parrot.png")
    player.spriteSheet = love.graphics.newImage("sprites/player-sheet.png")
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animetions = {}
    player.animetions.down = anim8.newAnimation(player.grid("1-4", 1), player.framerate)
    player.animetions.left = anim8.newAnimation(player.grid("1-4", 2), player.framerate)
    player.animetions.right = anim8.newAnimation(player.grid("1-4", 3), player.framerate)
    player.animetions.up = anim8.newAnimation(player.grid("1-4", 4), player.framerate)

    player.anim = player.animetions.left

    background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animetions.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animetions.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animetions.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animetions.down
        isMoving = true
    end

    if isMoving == false then
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5)
end
