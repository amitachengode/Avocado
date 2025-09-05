class=require 'class'

local Animation=class()

function Animation.init(self,sprite_sheet,width,height,frame_duration)
    self.animations={}
    self.sprite_sheet=love.graphics.newImage(sprite_sheet)

    self.current_time=0
    self.current_frame_row=1
    self.current_frame_column=1

    self.frame_count=math.floor(self.sprite_sheet:getWidth()/width)

    self.frame_duration=frame_duration or 0.1
    self.total_duration=self.frame_count*self.frame_duration

    for y=0,sprite_sheet:getHeight()-height,height do
        local frames={}
        for x=0,sprite_sheet:getWidth()-width,width do
            table.insert(frames,love.graphics.newQuad(x,y,width,height,sprite_sheet:getDimensions()))
        table.insert(self.animations,frames)
        end
    end
end

function Animation:update(dt)
    self.current_time=self.current_time+dt
    if self.current_time>=self.total_duration then
        self.current_time=self.current_time-self.total_duration
    end
    self.current_frame_column=math.floor(self.current_time/self.frame_duration)+1
end

function Animation:draw(x,y,scaleX,scaleY)
    love.graphics.draw(self.sprite_sheet,self.animations[self.current_frame_row][self.current_frame_column],x,y,0,scaleX or 1,scaleY or 1)
end

function Animation:setAnimation(row)
    self.current_frame_row=row
end

return Animation