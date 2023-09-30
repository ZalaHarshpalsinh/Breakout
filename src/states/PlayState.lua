--This state represents the active play part of the game 

--inherit from BaseState
PlayState = Class{__includes = BaseState}

function PlayState:init()
    --Create a Paddle
    self.paddle = Paddle()

    --create a ball with random skin out of 7 options
    self.ball = Ball()

    --center the ball
    self.ball.x = VIRTUAL_WIDTH/2 - self.ball.width/2
    self.ball.y = VIRTUAL_HEIGHT/2 - self.ball.height/2

    --give ball some random velocity
    self.ball.dx = math.random(-200,200)
    self.ball.dy = math.random(-200,200)
    
    --bool to know if game is paused or not
    self.paused = false
end

function PlayState:update(dt)

    --if user pressed space pause/resume the game
    if love.keyboard.wasPressed('space') then
        self.paused = not self.paused
    end
    
    --Update the paddle only if game is resumed
    if(self.paused==false)then  
        --update the paddle
        self.paddle:update(dt)
        --update the ball
        self.ball:update(dt)

        --detect collision of ball with paddle
        if self.ball:collides(self.paddle) then
            --bounce the ball in other direction
            self.ball.dy = -self.ball.dy
        end
    end

    --if user presses escape take him to menu
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
end

function PlayState:render()

    --render the paddle 
    self.paddle:render()

    --render the ball
    self.ball:render()

    --if game is paused, display Pause text
    if self.paused then
        print('PAUSED','large',0,VIRTUAL_HEIGHT/2-16,VIRTUAL_WIDTH,'center')
    end
end

