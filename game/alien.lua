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

    self.keypressed={w=false,a=false,s=false,d=false,shift=false}
    
    self.world=world
    self.body=love.physics.newBody(world,self.x,self.y,"dynamic")
    self.shape=love.physics.newRectangleShape(self.width,self.height)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.body:setFixedRotation(true)
    self.Fixture:setRestitution(1)
end

function Alien:left(dt)
    if self.keypressed.a then
        local x,y=self.body:getLinearVelocity()
        if self.keypressed.shift then
            self.current_speed=self.max_speed
            self.current_animation=self.animation_style.left_run
            self.current_animation_style="left_run"
        else
            self.current_speed=self.speed
            self.current_animation=self.animation_style.left
            self.current_animation_style="left"
        end
        self.Body:setLinearVelocity(x-self.current_speed,y)
    end
end

function Alien:right(dt)
    if self.keypressed.d then
        local x,y=self.body:getLinearVelocity()
        if self.keypressed.shift then
            self.current_speed=self.max_speed
            self.current_animation=self.animation_style.right_run
            self.current_animation_style="right_run"
        else
            self.current_speed=self.speed
            self.current_animation=self.animation_style.right
            self.current_animation_style="right"
        end
        self.Body:setLinearVelocity(x+self.current_speed,y)
    end
end

function Alien:jump(dt)
    if self.keypressed.w then
        local x,y=self.body:getLinearVelocity()
        self.current_animation=self.animation_style.jump
        self.current_animation_style="jump"
        self.body:setLinearVelocity(x,y-self.jump_speed)
    end
end

function Alien:duck()
    if self.keypressed.s then
        self.current_animation=self.animation_style.duck
        self.current_animation_style="duck"
        self.body:setLinearVelocity(0,0)
    end
end

function Alien:idle()
    if not (self.keypressed.w or self.keypressed.a or self.keypressed.s or self.keypressed.d) then
        self.current_animation=self.animation_style.idle
        self.current_animation_style="idle"
        self.body:setLinearVelocity(0,0)
    end
end

function Alien:update(dt)
    self:jump(dt)
    self:left(dt)
    self:right(dt)
    self:duck()
    self:idle()
    self.current_animation:update(dt)
end

function Alien:draw()
    local x,y=self.body:getPosition()
    self.current_animation:draw(x-self.sprite_width/2,y-self.sprite_height/2)
end

return Alien