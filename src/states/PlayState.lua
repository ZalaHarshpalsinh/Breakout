--This state represents the active play part of the game 

--inherit from BaseState
PlayState = Class{__includes = BaseState}

function PlayState:init()
    --Create a Paddle
    self.paddle = Paddle()

    --create a ball with random skin out of 7 options
    self.ball = Ball()

    self.bricks = LevelMaker.createMap()

    --center the ball
    self.ball.x = VIRTUAL_WIDTH/2 - self.ball.width/2
    self.ball.y = VIRTUAL_HEIGHT/2 - self.ball.height/2

    --give ball some random velocity
    self.ball.dx = math.random(-200,100)
    self.ball.dy = math.random(-200,100)
    
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
            if(self.ball.y < self.paddle.y+self.paddle.height/2) then
                self.ball.dy = - math.abs(self.ball.dy)
            else
                self.ball.dy =  math.abs(self.ball.dy)
            end
            
            if self.ball.dx > 0 and self.paddle.dx < 0 then
                local dis = self.paddle.x+self.paddle.width - (self.ball.x + self.ball.width)
                self.ball.dx = - (50 + (2*(math.abs(dis))))
            elseif self.ball.dx < 0 and self.paddle.dx > 0 then
                local dis = self.ball.x - self.paddle.x
                self.ball.dx =  (50 + (2*(math.abs(dis))))
            end
        end

        for i,brick in pairs(self.bricks) do
            if not brick.destroyed and self.ball:collides(brick) then
                brick.destroyed = true;

                if self.ball.x < brick.x  then
                    self.ball.dx = -self.ball.dx
                    self.ballx = brick.x - self.ball.width
                elseif self.ball.x+self.ball.width > brick.x + brick.width  then
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x+brick.width
                elseif self.ball.y < brick.y then
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y - self.ball.height
                else
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + 16
                end
                break
            end
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

    for i,brick in pairs(self.bricks) do
        self.bricks[i]:render()
    end

    --if game is paused, display Pause text
    if self.paused then
        print('PAUSED','large',0,VIRTUAL_HEIGHT/2-16,VIRTUAL_WIDTH,'center')
    end
end

