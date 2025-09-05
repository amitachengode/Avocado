class=require 'class'
anim=require 'animation'

local WIDTH=nil
local HEIGHT=nil
local BASE_SPEED=nil
local MAX_SPEED=nil
local FRAME_DURATION=nil
local SPRITE_WIDTH=nil
local SPRITE_HEIGHT=nil
local JUMP_SPEED=nil

local Alien=class()

---comment
---@param x any
---@param y any
---@param width any
---@param height any
---@param spritesheet table[left=string, right=string, jump=string, duck=string, idle=string, right_run=string,left_run=string]
---@param world love.physics.World
function Alien:init(world,x,y,width,height,spritesheet)
    self.x=x
    self.y=y
    self.width=width or WIDTH
    self.height=height or HEIGHT
    self.spritesheet=spritesheet
    self.speed=BASE_SPEED
    self.max_speed=MAX_SPEED
    self.jump_speed=JUMP_SPEED
    self.current_speed=BASE_SPEED

    self.animation_style={left=anim(spritesheet.left,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          right=anim(spritesheet.right,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          jump=anim(spritesheet.jump,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          duck=anim(spritesheet.duck,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          idle=anim(spritesheet.idle,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          left_run=anim(spritesheet.left_run,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION),
                          right_run=anim(spritesheet.right_run,SPRITE_WIDTH,SPRITE_HEIGHT,FRAME_DURATION)}
    self.current_animation=self.animation_style.idle
    self.current_animation_style="idle"
    self.sprite_width=SPRITE_WIDTH
    self.sprite_height=SPRITE_HEIGHT
    
    self.world=world
    self.body=love.physics.newBody(world,self.x,self.y,"dynamic")
    self.shape=love.physics.newRectangleShape(self.width,self.height)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body:setFixedRotation(true)
    self.Fixture:setRestitution(1)
end

