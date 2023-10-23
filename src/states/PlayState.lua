--This state represents the active play part of the game 

--inherit from BaseState
PlayState = Class{__includes = BaseState}

function PlayState:enter(paras)
    --Create a Paddle
    self.paddle = paras.paddle

    --create a ball with random skin out of 7 options
    self.balls = {paras.ball}

    self.bricks = paras.bricks

    self.health = paras.health
    self.score = paras.score
    self.level = paras.level

    self.active_bricks = #self.bricks
    
    --give ball some random velocity

    self.balls[1].dx = math.random(-200,200)
    self.balls[1].dy = math.random(-150,-100)
    
    --bool to know if game is paused or not
    self.paused = false

    self.hits_target = {
        ['extra_balls'] = math.random(5,10),
        ['key'] = self.active_bricks/2
    }
    self.hits_count = 0

    self.powerups = {}

    self.locked_brick_index = 0
    for i,brick in pairs(self.bricks) do
        if brick.locked then
            self.locked_brick_index = i
        end
    end
end

function PlayState:spawn_powerup(x,y)
    if Key.should_spawn(self) then
        table.insert(self.powerups,Key(x,y))
    elseif Life.should_spawn(self) then
        table.insert(self.powerups,Life(x,y))
    elseif ExtraBalls.should_spawn(self) then
        table.insert(self.powerups,ExtraBalls(x,y))
    elseif PaddleSizeUp.should_spawn(self) then
        table.insert(self.powerups,PaddleSizeUp(x,y))
    end
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

        for i,ball in pairs(self.balls) do

            --update the ball
            ball:update(dt)

             --detect collision of ball with paddle
            if collides(ball,self.paddle) then
                --bounce the ball in other direction
                if(ball.y < self.paddle.y+self.paddle.height/2) then
                    ball.dy = - math.abs(ball.dy)
                else
                    ball.dy =  math.abs(ball.dy)
                end
                
                if ball.dx > 0 and self.paddle.dx < 0 then
                    local dis = self.paddle.x+self.paddle.width - (ball.x + ball.width)
                    ball.dx = - (50 + (2*(math.abs(dis))))
                elseif ball.dx < 0 and self.paddle.dx > 0 then
                    local dis = ball.x - self.paddle.x
                    ball.dx =  (50 + (2*(math.abs(dis))))
                end
            end

            for i,brick in pairs(self.bricks) do

                brick:update(dt)

                if not brick.destroyed and collides(ball,brick) then

                    if not brick.locked then
                        brick:hit()
                    end
                    
                    self.score = self.score + 10
                    self.hits_count = self.hits_count + 1

                    self:spawn_powerup(brick.x+TILE_WIDTH/2,brick.y+TILE_HEIGHT)

                    if(brick.destroyed) then self.active_bricks = self.active_bricks -1 end
                    if(self.active_bricks == 0) then 
                        gStateMachine:change('LevelCompleteState',{
                            level = self.level,
                            paddle = self.paddle,
                            health = self.health,
                            score = self.score
                        })
                    end

                    if ball.x + 10  < brick.x  then
                        ball.dx = -ball.dx
                        ballx = brick.x - ball.width 
                    elseif ball.x+ball.width - 10
                    > brick.x + brick.width  then
                        ball.dx = -ball.dx
                        ball.x = brick.x+brick.width
                    elseif ball.y < brick.y then
                        ball.dy = -ball.dy
                        ball.y = brick.y - ball.height
                    else
                        ball.dy = -ball.dy
                        ball.y = brick.y + brick.height
                    end
                    break
                end
            end
            
            if ball.y >= VIRTUAL_HEIGHT then
                table.remove(self.balls,i)
                if #self.balls == 0 then
                    self.health = self.health - 1
                    if self.health == 0 then
                        gStateMachine:change('GameOverState',{
                            score = self.score
                        })
                    else
                        if self.paddle.size~=1 then
                            self.paddle.size = self.paddle.size - 1 
                        end
                        gStateMachine:change('ServeState',{
                            paddle = self.paddle,
                            bricks = self.bricks,
                            health = self.health,
                            score = self.score,
                            level = self.level
                        })
                    end
                end
            end
        end

        for i,powerup in pairs(self.powerups) do
            --update the ball
            powerup:update(dt)
            if collides(self.paddle,powerup) then
                powerup.cause_effect(self)
                table.remove(self.powerups,i)
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
    for i,ball in pairs(self.balls) do
        ball:render()
    end
    
    for i,brick in pairs(self.bricks) do
        self.bricks[i]:render()
    end

    for i,powerup in pairs(self.powerups) do
        powerup:render()
    end

    renderHealth(self.health)
    renderScore(self.score)

    --if game is paused, display Pause text
    if self.paused then
        print('PAUSED','large',0,VIRTUAL_HEIGHT/2-16,VIRTUAL_WIDTH,'center')
    end
end

