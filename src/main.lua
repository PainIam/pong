push = require "push" -- load push library
Class = require "class"

require "Paddle"
require "Ball"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("PONG")

    font = love.graphics.newFont("/fonts/font.ttf", 8)
    largeFont = love.graphics.newFont("fonts/font.ttf", 16)
    scoreFont = love.graphics.newFont("fonts/font.ttf", 32)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsync = true,
        fullscreen = false

    })

    math.randomseed(os.time())

    sounds = {
        ["paddle_hit"]  = love.audio.newSource("/sounds/paddle_hit.wav", "static"),
        ["score"]       = love.audio.newSource("/sounds/score.wav", "static"),
        ["wall_hit"]    = love.audio.newSource("/sounds/wall_hit.wav", "static")      

    }

    -- ini score variables
    player1Score = 0
    player2Score = 0

    -- turn
    servingPlayer = 1

    winner = 0

    -- paddle y's
    player1Y = 10
    player2Y = VIRTUAL_HEIGHT - 30

    -- paddle x's
    player1X = 10
    player2X = 422 - 5

    -- ball's ini position
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- ini paddle objects
    player1 = Paddle(player1X, player1Y, 5, 20)
    player2 = Paddle(player2X, player2Y, 5, 20)

    -- ini ball object
    ball = Ball(ballX, ballY, 4, 4)



    -- the state of the game; can be any of the following:
    -- 1. 'start' (the beginning of the game, before first serve)
    -- 2. 'serve' (waiting on a key press to serve the ball)
    -- 3. 'play' (the ball is in play, bouncing between paddles)
    -- 4. 'done' (the game is over, with a victor, ready for restart)
    gameState = "start"

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = "normal" })
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.update(dt)


    if gameState == "serve" then 

        -- set the velocity of ball based on who's currently serving
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    elseif gameState == "play" then
        
        --detect whether a players paddle collides with ball
        -- if so, reverse the dx and increase it slightly
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            -- randomize dy, but keep the direction
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds["paddle_hit"]:play()
        end 
        
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            
            end
            
            sounds["paddle_hit"]:play()
        end
    end

    if love.keyboard.isDown('w') then

        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then

        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0 -- dy (0) * dt will result in no movement
    end

    if love.keyboard.isDown('up') then

        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then

        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0 -- uniform paddles
    end

    -- detect upper screen collion
    if ball.y <= 0 then 
        ball.y = 0
        ball.dy = -ball.dy -- reverse delta y

        sounds["wall_hit"]:play()
    end

    -- detect lower screen collion
    if ball.y + ball.height > VIRTUAL_HEIGHT then
        ball.y = VIRTUAL_HEIGHT - ball.height
        ball.dy = -ball.dy

        sounds["wall_hit"]:play()
    end

    --update scores based on if ball collides with left or right of the screen
    if ball.x <= 0 then
        sounds["score"]:play()
        servingPlayer = 1
        player2Score = player2Score + 1

        if player2Score == 4 then
            winner = 2
            gameState = "done"
        else
            gameState = "serve"
        end
        ball:reset()
    end

    if ball.x + ball.width > VIRTUAL_WIDTH then
        sounds["score"]:play()
        servingPlayer = 2
        player1Score = player1Score + 1

        if player1Score == 4 then
            winner = 1
            gameState = "done"
        else
            gameState = "serve"


        end
        ball:reset()
    end

    if gameState == "play" then
        ball:update(dt)
    end

    -- paddles move regardless of state
    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)


    -- state management
    if key == "escape" then
        love.event.quit()
    elseif key == "return" or key == "enter" then
        if gameState == "start" then
            gameState = "serve"
        elseif gameState == "serve" then
            gameState = "play"
        elseif gameState == "done" then

            gameState = "serve"
            ball:reset()

            -- reset players scores
            player1Score = 0
            player2Score = 0

            if winner == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end


function love.draw()
    push.start()

    -- love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == "start" then

        love.graphics.setFont(font)
        love.graphics.printf("Welcome To Pong!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press Enter To Begin", 0, 20, VIRTUAL_WIDTH, "center")
    elseif gameState == "serve" then
        
        love.graphics.setFont(font)
        love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s serve!",
                              0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press Enter To Serve", 0, 20, VIRTUAL_WIDTH, "center")

    elseif gameState == "play" then
        
        -- important because there exist another state besides this, so an else won't suffice
    elseif gameState == "done" then

        love.graphics.setFont(largeFont)
        love.graphics.printf("Player " .. tostring(winner) .. " wins!", 0, 10,
                              VIRTUAL_WIDTH, "center")
        love.graphics.printf("press enter to serve!", 0, 25, VIRTUAL_WIDTH, "center")
    end
    

    displayScore()
    
    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    push.finish()
end

function displayScore()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

end


function displayFPS()

    love.graphics.setFont(font)
    love.graphics.setColor(0, 1, 0, 1 )
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10) -- .. is string concat ...christ
    love.graphics.setColor(1, 1, 1, 1)

end


