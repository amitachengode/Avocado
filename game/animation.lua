class = require 'class'

local Animation=class()

function Animation:init(sprite_sheet, width, height, frame_duration)
    self.animations={}
    self.sprite_sheet=love.graphics.newImage(sprite_sheet)

    self.width=width
    self.height=height
    self.current_time=0
    self.current_frame= 1

    self.frame_duration=frame_duration or 0.1

    local spritewidth,spriteheight=self.sprite_sheet:getDimensions()
    self.frame_count=(spritewidth/width)*(spriteheight/height)
    self.total_duration=self.frame_count*self.frame_duration
    for y = 0,spriteheight-height,height do
        for x = 0,spritewidth-width,width do
            local frames=love.graphics.newQuad(x,y,width,height,spritewidth,spriteheight)
            table.insert(self.animations,frames)
        end
    end
end

function Animation:update(dt)
    self.current_time=self.current_time + dt
    if self.current_time>=self.total_duration then
        self.current_time=self.current_time-self.total_duration
    end
    self.current_frame=math.floor(self.current_time/self.frame_duration)+1
end

function Animation:draw(x, y, scaleX, scaleY)
    love.graphics.draw(self.sprite_sheet,self.animations[self.current_frame],x, y, 0,scaleX or 1, scaleY or 1)
end

return Animation