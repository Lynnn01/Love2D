function love.load()
    anim8 = require "libraries/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Player setup
    player = {
        x = 400,
        y = 200,
        speed = 5,
        framerate = 0.1,
        sprite = love.graphics.newImage("sprites/parrot.png"),
        spriteSheet = love.graphics.newImage("sprites/player-sheet.png"),
        animations = {}
    }

    local grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations.down = anim8.newAnimation(grid("1-4", 1), player.framerate)
    player.animations.left = anim8.newAnimation(grid("1-4", 2), player.framerate)
    player.animations.right = anim8.newAnimation(grid("1-4", 3), player.framerate)
    player.animations.up = anim8.newAnimation(grid("1-4", 4), player.framerate)

    player.anim = player.animations.left

    -- Background setup
    background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if not isMoving then
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5)
end
