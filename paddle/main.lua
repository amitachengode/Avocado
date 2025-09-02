WINDOW_WIDTH=1280
WINDOW_HEIGHT=720
VIRTUAL_WIDTH=432
VIRTUAL_HEIGHT=243

push=require 'push'
class=require 'class'
require 'Ball'
require 'Paddle'

function love.load()
    math.randomseed(os.time())
    sounds={paddle=love.audio.newSource('sounds/paddle.wav','static'),wall=love.audio.newSource('sounds/wall.wav','static'),win=love.audio.newSource('sounds/win.wav','static'),gooff=love.audio.newSource('sounds/gooff.wav','static')}
    love.graphics.setDefaultFilter('nearest','nearest')
    largefont=love.graphics.newFont('font.ttf',24)
    smallfont=love.graphics.newFont('font.ttf',12)
    love.window.setTitle('Pong')
    player1=Paddle(5,20,5,30)
    player2=Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-20,5,30)
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{vsync=true,resizable=true,fullscreen=false})
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT)
    ball=Ball(VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
    game_state='start'
end

function love.resize(w,h)
    push:resize(w,h)
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
        collision()
    end
end

function collision()
    if ball:collision(player1) then
        sounds['paddle']:play()
        ball.dx=-ball.dx*1.1
        ball.x=player1.x+player1.width
        ball.dy=ball.dy*1.05
    end
    if ball:collision(player2) then
        sounds['paddle']:play()
        ball.dx=-ball.dx*1.1
        ball.x=player2.x-player2.width
        ball.dy=ball.dy*1.05
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
        elseif game_state=='end' then
            ball:reset()
            player1.score=0
            player2.score=0
            game_state='play'
        end
    end
end


function love.draw()
    push:start()
    love.graphics.setFont(largefont)
    love.graphics.clear(40/255,45/255,52/255,1)
    if game_state=='start' then
        love.graphics.printf("Welcome to Pong!",0,20,VIRTUAL_WIDTH,'center')
        love.graphics.printf("Press SPACE to start the game",0,VIRTUAL_HEIGHT-60,VIRTUAL_WIDTH,'center')
    elseif game_state=='player1Serve' or game_state=='player2Serve' then
        love.graphics.printf("Press SPACE to serve to the other player.",0,VIRTUAL_HEIGHT-60,VIRTUAL_WIDTH,'center')
    elseif game_state=='end' then
        love.graphics.printf("Player " .. tostring(winner) .. " wins!",0,20,VIRTUAL_WIDTH,'center')
        love.graphics.printf("Press SPACE to restart the game",0,VIRTUAL_HEIGHT-60,VIRTUAL_WIDTH,'center')
        sounds['win']:play()
    end
    
    -- paddle 1
    player1:draw()
    -- paddle 2
    player2:draw()
    --BALL
    ball:draw()
    love.graphics.print(tostring(player1.score),VIRTUAL_WIDTH/2-70,VIRTUAL_HEIGHT/2-80)
    love.graphics.print(tostring(player2.score),VIRTUAL_WIDTH/2+50,VIRTUAL_HEIGHT/2-80)
    getFPS()
    if player1.score==10 then
        game_state='end'
        winner=1
    elseif player2.score==10 then
        game_state='end'
        winner=2
    end
    push:finish()
end

function getFPS()
    love.graphics.setFont(smallfont)
    love.graphics.setColor(0,1,0,1)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()),10,10)
    love.graphics.setColor(1,1,1,1)
end