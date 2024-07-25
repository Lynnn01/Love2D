Player = {}
Player.__index = Player

function Player.new()
    local self = setmetatable({}, Player)

    love.graphics.setDefaultFilter("nearest", "nearest")
    self.x = 400
    self.y = 200
    self.speed = 250
    self.framerate = 0.1
    self.sprite = love.graphics.newImage("sprites/parrot.png")
    self.spriteSheet = love.graphics.newImage("sprites/player-sheet.png")
    self.animations = {}
    self.anim = nil

    self:initializeAnimations()

    return self
end

function Player:initializeAnimations()
    anim8 = require "libraries/anim8"
    local grid = anim8.newGrid(12, 18, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations.down = anim8.newAnimation(grid("1-4", 1), self.framerate)
    self.animations.left = anim8.newAnimation(grid("1-4", 2), self.framerate)
    self.animations.right = anim8.newAnimation(grid("1-4", 3), self.framerate)
    self.animations.up = anim8.newAnimation(grid("1-4", 4), self.framerate)
    self.anim = self.animations.left
end

function Player:update(dt)
    local isMoving = false
    self:push()

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        self.anim = self.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        self.anim = self.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
        self.anim = self.animations.up
        isMoving = true
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
        self.anim = self.animations.down
        isMoving = true
    end

    if not isMoving then
        self.anim:gotoFrame(2)
    end

    self.anim:update(dt)
end

function Player:push()
    if love.keyboard.isDown("lshift") then
        self.speed = 400
    elseif love.keyboard.isDown("lctrl") then
        self.speed = 100
    else
        self.speed = 250
    end
end

function Player:draw()
    local sprite = {}
    if love.keyboard.isDown("z") then
        if love.keyboard.isDown("x") then
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.draw(self.sprite, self.x, self.y, nil, 0.3)
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.draw(self.sprite, self.x, self.y, nil, 0.3)
        end
    else
        if love.keyboard.isDown("x") then
            love.graphics.setColor(1, 1, 1, 0.5)
            self.anim:draw(self.spriteSheet, self.x, self.y, nil, 3)
            love.graphics.setColor(1, 1, 1, 1)
        else
            self.anim:draw(self.spriteSheet, self.x, self.y, nil, 3)
        end
    end
end

return Player
