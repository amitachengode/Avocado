class=require 'class'

Block=class()

function Block:init(world,x,y,w,h,image)
    self.x=x
    self.y=y
    self.w=w
    self.h=h

    self.body=love.physics.newBody(world,x,y,'static')
    self.shape=love.physics.newRectangleShape(w,h)
    self.fixture=love.physics.newFixture(self.body,self.shape)
    self.Fixture:setRestitution(0)

    self.image=love.graphics.newImage(image)
end

function Block:draw()
    love.graphics.draw(self.image,self.body:getX(),self.body:getY(),)
end

return Block