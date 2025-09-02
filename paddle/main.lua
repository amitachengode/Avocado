WINDOW_WIDTH=1280
WINDOW_HEIGHT=720
VIRTUAL_WIDTH=432
VIRTUAL_HEIGHT=243

PADDLE_SIZEY=30
PADDLE_SPEED=200

push=require 'push'
class=require 'class'
require 'Ball'
require 'Paddle'

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest','nearest')
    font=love.graphics.newFont('font.ttf',24)
    love.window.setTitle('Pong')
    player1=Paddle(5,20,5,30)
    player2=Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-20,5,30)
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{vsync=true,resizable=false,fullscreen=false})
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{upscale='normal'})
    ball=Ball(VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
    game_state='start'
end

function love.update(dt)
    if game_state=='play' then
        ball:update(dt)
        if love.keyboard.isDown('w') then
            player1.speed=-200
        elseif love.keyboard.isDown('s') then
            player1.speed=200
        else
            player1.speed=0
        end
        
        if love.keyboard.isDown('up') then
            player2.speed=-200
        elseif love.keyboard.isDown('down') then
            player2.speed=200
        else 
            player2.speed=0
        end
        player1:update(dt)
        player2:update(dt)
    end
end

function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    elseif key=='space' then
        if game_state=='start' then
            ball:reset()
            game_state='play'
        elseif game_state=='player1Serve' or game_state=='player2Serve' then
            ball:reset()
            game_state='play'
        end
    end
end


function love.draw()
    push:start()
    love.graphics.setFont(font)
    love.graphics.clear(40/255,45/255,52/255,1)
    if game_state=='start' then
        love.graphics.printf("Press SPACE to start the game",0,VIRTUAL_HEIGHT-60,VIRTUAL_WIDTH,'center')
    elseif game_state=='player1Serve' or game_state=='player2Serve' then
        love.graphics.printf("Press SPACE to serve to the other player.",0,VIRTUAL_HEIGHT-60,VIRTUAL_WIDTH,'center')
    end
    -- paddle 1
    player1:draw()
    -- paddle 2
    player2:draw()
    --BALL
    ball:draw()
    love.graphics.print(tostring(player1.score),VIRTUAL_WIDTH/2-70,VIRTUAL_HEIGHT/2-80)
    love.graphics.print(tostring(player2.score),VIRTUAL_WIDTH/2+50,VIRTUAL_HEIGHT/2-80)
    push:finish()
end

function getFPS()
    love.setColor(0,1,0,1)
    love.graphics.print("FPS: ", tostring(love.timer.getFPS()),10,10)