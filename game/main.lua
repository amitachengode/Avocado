--[[
class=require 'class'
Animation=require 'animation'
function love.load()
    love.window.setMode(0,0)
    sprite=Animation('boy moving.png',1024,1024,0.2)
end

function love.update(dt)
    sprite:update(dt)
end

function love.draw()
    love.graphics.clear(1,1,1,1)
    sprite:draw()
end]]

class=require 'class'
Animation=require 'animation'
player=require 'player'

function love.load()
    love.window.setMode(0,0)
    player=player()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.clear(1,1,1,1)
    player:draw()
end


