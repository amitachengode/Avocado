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

require 'class'
require 'animation'
require 'player'
require 'world'

function love.load()
    love.window.setMode(0,0)
    world=World()
    player1=Player(world,500,0)
    world:add_body(player)
end

function love.update(dt)
    player1:update(dt)
    world:update(dt)
end

function love.draw()
    love.graphics.clear(1,1,1,1)
    world:draw()
end

