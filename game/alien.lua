class=require 'class'
anim=require 'animation'
Player=require 'player'

local FRAME_WIDTH=nil
local FRAME_HEIGHT=nil
local BASE_SPEED=nil
local MAX_SPEED=nil
local CATCHING_DISTANCE=nil
local ATTACK_DISTANCE=nil
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

local Alien=class()

---comment
---@param x any
---@param y any
---@param world love.physics.World
---@param player Player
function Alien:init(world,player,x,y)
    self.x=x
    self.y=y
    self.width=FRAME_WIDTH
    self.height=FRAME_HEIGHT
    self.spritesheet=SPRITE_SHEET_TABLE
    self.speed=BASE_SPEED
    self.max_speed=MAX_SPEED
    self.jump_speed=JUMP_SPEED
    self.current_speed=self.speed
    self.catching_distance=CATCHING_DISTANCE
    self.attack_distance=ATTACK_DISTANCE

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
    
    self.world=world
    self.body=love.physics.newBody(world,self.x,self.y,"dynamic")
    self.shape=love.physics.newRectangleShape(self.width,self.height)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body:setFixedRotation(true)
    self.Fixture:setRestitution(0)

    self.player=player
end

function Alien:wander()
    -- to be implemented
end

function Alien:attack_player()
    -- to be implemented
end

function Alien:chase_player()
    -- to be implemented
end

function Alien:draw()
    local ax,ay=self.body:getPosition()
end

return Alien
