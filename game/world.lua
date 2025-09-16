class=require 'class'
anim=require 'animation'

local World=class()

function World:init(gravity_x,gravity_y,pixels_per_meter)
    self.gravity_x=gravity_x or 0
    self.gravity_y=gravity_y or 9.81
    self.world=love.physics.newWorld(self.gravity_x,self.gravity_y,true)
    self.world.setMeter(pixels_per_meter or 32)
    self.bodies={}
end

function World:add_body(body)
    table.insert(self.bodies,body)
end

function World:update(dt)
    self.world:update(dt)
    for i,body in ipairs(self.bodies) do
        body.current_animation:update(dt)
        body:update()
    end
end

function World:draw()
    for i,body in ipairs(self.bodies) do
        body.current_animation:draw(body.body:getX()-body.sprite_width/2,body.body:getY()-body.sprite_height/2)
    end
end

function World:remove_body(body)
    for i,b in ipairs(self.bodies) do
        if b.body==body then
            table.remove(self.bodies,i)
            break
        end
    end
    body.body:destroy()
end

return World