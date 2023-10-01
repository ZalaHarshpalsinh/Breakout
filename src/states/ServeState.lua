ServeState = Class{__includes = BaseState}

function ServeState:enter(paras)
    self.paddle = paras.paddle
    self.bricks = paras.bricks
    self.health = paras.health
    self.score = paras.score
    
    self.ball = Ball() 
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - (self.ball.width/2)
    self.ball.y = self.paddle.y - self.ball.height

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('PlayState',{
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball
        })
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()
    
    for i,brick in pairs(self.bricks) do
        brick:render()
    end

    renderHealth(self.health)
    renderScore(self.score)

    print('Press Enter to serve!','medium',0,VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH,'center')
end