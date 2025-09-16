class=require 'class'
Animation=require 'animation'

local FRAME_WIDTH=nil
local FRAME_HEIGHT=nil
local BASE_SPEED=nil
local MAX_SPEED=nil
local SPRITE_WIDTH=nil
local SPRITE_HEIGHT=nil
local FRAME_DURATION=nil
local JUMP_SPEED=nil
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
    
    self.animation_style={
        left=Animation(SPRITE_SHEET_TABLE.left,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        right=Animation(SPRITE_SHEET_TABLE.right,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        jump=Animation(SPRITE_SHEET_TABLE.jump,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        duck=Animation(SPRITE_SHEET_TABLE.duck,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        idle=Animation(SPRITE_SHEET_TABLE.idle,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        right_run=Animation(SPRITE_SHEET_TABLE.right_run,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION),
        left_run=Animation(SPRITE_SHEET_TABLE.left_run,FRAME_WIDTH,FRAME_HEIGHT,FRAME_DURATION)
    }
    
    self.current_animation=self.animation_style.idle
    self.current_animation_style="idle"
    self.sprite_width=SPRITE_WIDTH
    self.sprite_height=SPRITE_HEIGHT

    self.world=world
    self.body=love.physics.newBody(world,x,y,"dynamic")
    self.shape=love.physics.newRectangleShape(0,0,SPRITE_WIDTH,SPRITE_HEIGHT)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body.setFixedRotation(true)
    self.fixture.setRestitution(1)

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
        self.current_animation=self.animation_style.jump
        self.current_animation_style="jump"
    end
    if self.key_pressed.a and self.key_pressed.shift then
        self.body:setPosition(px-self.max_speed*dt,py)
        self.current_animation=self.animation_style.left_run
        self.current_animation_style="left_run"
    elseif self.key_pressed.a then
        self.body:setPosition(px-self.speed*dt,py)
        self.current_animation=self.animation_style.left
        self.current_animation_style="left"
    end
    if self.key_pressed.s then
        self.body:setPosition(px,py+self.speed*dt)
        self.current_animation=self.animation_style.duck
        self.current_animation_style="duck"
    end
    if self.key_pressed.d and self.key_pressed.shift then
        self.body:setPosition(px+self.max_speed*dt,py)
        self.current_animation=self.animation_style.right_run
        self.current_animation_style="right_run"
    elseif self.key_pressed.d then
        self.body:setPosition(px+self.speed*dt,py)
        self.current_animation=self.animation_style.right
        self.current_animation_style="right"
    end
end

function player:update(dt)
    self:update_keypress(dt)
    self:update_motion(dt)
    self.current_animation:update(dt)
end

function player:draw()
    local px,py=self.body.getPosition()
    self.current_animation:draw(px,py)
end

return player