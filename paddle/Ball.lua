require 'class'
Ball=class{}

function Ball:init(x,y,WIDTH,HEIGHT)
    self.x=x
    self.y=y
    self.WIDTH=WIDTH
    self.HEIGHT=HEIGHT
    self.dx=math.random(2)==1 and 100 or -100
    self.dy=math.random(-50,50)
end

function Ball:collision(paddle)
    -- checking first if left paddle's right edge and ball's left edge are colliding
    if paddle.x+paddle.width<self.x or paddle.x>=self.x+self.width then
        return false
    end
    return true
end

function Ball:update(dt)
    self.x=self.x+self.dx*dt
    self.y=self.y+self.dy*dt
    if self.y>VIRTUAL_HEIGHT or self.y<0 then
        self.dy=-self.dy
    end
    if self.x<0 then
        player2.score=player2.score+1
        game_state='player1Serve'
        self:reset()
    elseif self.x>VIRTUAL_WIDTH then
        player1.score=player1.score+1
        game_state='player2Serve'
        self:reset()
    end
end

function Ball:reset()
    self.x=VIRTUAL_WIDTH/2-2
    self.y=VIRTUAL_HEIGHT/2-2
    if game_state=='player1Serve' then
        self.dx=100
    elseif game_state=='player2Serve' then
        self.dx=-100
    end
    self.dy=math.random(-50,50)
end

function Ball:draw()
    love.graphics.rectangle('fill',self.x,self.y,self.WIDTH,self.HEIGHT)
end