Paddle=class{}

function Paddle:init(x,y,WIDTH,HEIGHT)
    self.x=x
    self.y=y
    self.width=WIDTH
    self.height=HEIGHT
    self.speed=0
    self.score=0
end

function Paddle:update(dt)
    self.y=self.y+self.speed*dt
    if self.y<0 then
        self.y=0
    elseif self.y+self.height>VIRTUAL_HEIGHT then
        self.y=VIRTUAL_HEIGHT-self.height
    end
end

function Paddle:draw()
    love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
end