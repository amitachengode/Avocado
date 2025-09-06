class=require 'class'
anim=require 'animation'

local FRAME_WIDTH=nil
local FRAME_HEIGHT=nil
local BASE_SPEED=nil
local MAX_SPEED=nil
local FRAME_DURATION=nil
local SPRITE_WIDTH=nil
local SPRITE_HEIGHT=nil
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

local Player=class()
---comment
---@param x any
---@param y any
---@param world love.physics.World

function Player:init(world,x,y)
    self.x=x
    self.y=y
    self.width=FRAME_WIDTH
    self.height=FRAME_HEIGHT
    self.spritesheet=SPRITE_SHEET_TABLE
    self.speed=BASE_SPEED
    self.max_speed=MAX_SPEED
    self.jump_speed=JUMP_SPEED
    self.current_speed=self.speed

    self.animation_style={left=anim(SPRITE_SHEET_TABLE.left,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          right=anim(SPRITE_SHEET_TABLE.right,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          jump=anim(SPRITE_SHEET_TABLE.jump,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          duck=anim(SPRITE_SHEET_TABLE.duck,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          idle=anim(SPRITE_SHEET_TABLE.idle,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          left_run=anim(SPRITE_SHEET_TABLE.left_run,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          right_run=anim(SPRITE_SHEET_TABLE.right_run,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION)}
    self.current_animation=self.animation_style.idle
    self.current_animation_style="idle"
    self.sprite_width=SPRITE_WIDTH
    self.sprite_height=SPRITE_HEIGHT

    self.keypressed={w=false,a=false,s=false,d=false,shift=false}
    
    self.world=world
    self.body=love.physics.newBody(world,self.x,self.y,"dynamic")
    self.shape=love.physics.newRectangleShape(self.width,self.height)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body:setFixedRotation(true)
    self.Fixture:setRestitution(1)
end

function Player:update_keyboard()
    if love.keyboard.isDown("w") then
        self.keypressed.w=true
    end
    if love.keyboard.isDown("a") then
        self.keypressed.a=true
    end
    if love.keyboard.isDown("s") then
        self.keypressed.s=true
    end
    if love.keyboard.isDown("d") then
        self.keypressed.d=true
    end
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        self.keypressed.shift=true
    else
        self.keypressed.shift=false
    end
end

function Player:update(dt)
    Player:update_keyboard()
    if self.keypressed.d and not self.keypressed.a then
        if self.keypressed.shift then
            self.current_speed=self.max_speed
            if self.current_animation_style~="right_run" then
                self.current_animation=self.animation_style.right_run
                self.current_animation_style="right_run"
            end
        else
            self.current_speed=self.speed
            if self.current_animation_style~="right" then
                self.current_animation=self.animation_style.right
                self.current_animation_style="right"
            end
        end
        self.body:setX(self.body:getX()+self.current_speed*dt)
    elseif self.keypressed.a and not self.keypressed.d then
        if self.keypressed.shift then
            self.current_speed=self.max_speed
            if self.current_animation_style~="left_run" then
                self.current_animation=self.animation_style.left_run
                self.current_animation_style="left_run"
            end
        else
            self.current_speed=self.speed
            if self.current_animation_style~="left" then
                self.current_animation=self.animation_style.left
                self.current_animation_style="left"
            end
        end
        self.body:setX(self.body:getX()-self.current_speed*dt)
    else
        if self.current_animation_style~="idle" then
            self.current_animation=self.animation_style.idle
            self.current_animation_style="idle"
        end
    end

    if self.keypressed.w then
        if self.current_animation_style~="jump" then
            self.current_animation=self.animation_style.jump
            self.current_animation_style="jump"
        end
        local vx,vy=self.body:getLinearVelocity()
        if vy==0 then
            self.body:setLinearVelocity(vx,-self.jump_speed)
        end
    end

    if self.keypressed.s then
        if self.current_animation_style~="duck" then
            self.current_animation=self.animation_style.duck
            self.current_animation_style="duck"
        end
    end
end

function Player:draw()
    self.current_animation:draw(self.body:getX()-self.sprite_width/2,self.body:getY()-self.sprite_height/2)
end
