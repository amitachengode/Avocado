class=require 'class'
Animation=require 'animation'

local BASE_SPEED=10
local MAX_SPEED=20
local SPRITE_WIDTH=100
local SPRITE_HEIGHT=100
local FRAME_DURATION=nil
local JUMP_SPEED=10
local SPRITE_SHEET_TABLE={
    left="",
    right="",
    jump="",
    duck="",
    idle="",
    right_run="",
    left_run=""
}

player=class()
---@param world love.physics.world
---@param x int
---@param y int
function player:init(world,x,y)
    self.world=world
    self.x=x
    self.y=y
    self.width=SPRITE_WIDTH
    self.height=SPRITE_HEIGHT
    self.speed=BASE_SPEED
    self.max_speed=MAX_SPEED
    self.jump_speed=JUMP_SPEED
    
    self.sprite_width=SPRITE_WIDTH
    self.sprite_height=SPRITE_HEIGHT

    self.world=world
    self.body=love.physics.newBody(world,x,y,"dynamic")
    self.shape=love.physics.newRectangleShape(0,0,SPRITE_WIDTH,SPRITE_HEIGHT)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body.setFixedRotation(true)
    self.fixture.setRestitution(0)

    self.key_pressed={
        w=false,
        a=false,
        s=false,
        d=false,
        space=false,
        shift=false
    }
end

function player:update_keypress(dt)
    self.key_pressed.w=love.keyboard.isDown("w")
    self.key_pressed.a=love.keyboard.isDown("a")
    self.key_pressed.s=love.keyboard.isDown("s")
    self.key_pressed.d=love.keyboard.isDown("d")
    self.key_pressed.space=love.keyboard.isDown("space")
    self.key_pressed.shift=love.keyboard.isDown("lshift")
end

function player:update_motion(dt)
    local px,py=self.body.getPosition()
    if self.key_pressed.w then
        self.body:setPosition(px,py-self.speed*dt)
    end
    if self.key_pressed.a and self.key_pressed.shift then
        self.body:setPosition(px-self.max_speed*dt,py)
    elseif self.key_pressed.a then
        self.body:setPosition(px-self.speed*dt,py)
    end
    if self.key_pressed.s then
        self.body:setPosition(px,py+self.speed*dt)
    end
    if self.key_pressed.d and self.key_pressed.shift then
        self.body:setPosition(px+self.max_speed*dt,py)
    elseif self.key_pressed.d then
        self.body:setPosition(px+self.speed*dt,py)
    end
end

function player:update(dt)
    self:update_keypress(dt)
    self:update_motion(dt)
end

function player:draw()
    local px,py=self.body.getPosition()
    love.graphics.setColor(255,255,255,255) -- red (number), green (number), blue (number), alpha (number))
    love.graphics.rectangle("fill",px,py,SPRITE_WIDTH,SPRITE_HEIGHT)
end

return player