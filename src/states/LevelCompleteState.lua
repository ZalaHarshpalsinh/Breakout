LevelCompleteState = Class{__includes = BaseState}

function LevelCompleteState:enter(paras)
    self.level = paras.level
    self.paddle = paras.paddle
    self.health = paras.health
    self.score = paras.score
end

function LevelCompleteState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('ServeState',{
            paddle = self.paddle,
            score = self.score,
            health = self.health,
            bricks = LevelMaker.createMap(self.level+1),
            level = self.level+1
        })
    end
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
end

function LevelCompleteState:render()
    print('Level '..self.level..' Complete','large',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    print('Press enter','medium',0,VIRTUAL_HEIGHT/3+60,VIRTUAL_WIDTH,'center')
    self.paddle:render()
    renderHealth(self.health)
    renderScore(self.score)
end
