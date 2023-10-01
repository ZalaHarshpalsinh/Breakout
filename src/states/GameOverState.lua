GameOverState = Class{__includes = BaseState}

function GameOverState:enter(paras)
    self.score = paras.score
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('StartState')
    end
end

function GameOverState:render()
    print('GAME OVER','large',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    print('Final Score: ' .. tostring(self.score), 'medium' , 0, VIRTUAL_HEIGHT/2 ,VIRTUAL_WIDTH,'center')
    print('Press Enter!', 'medium',0,VIRTUAL_HEIGHT/2 + 40, VIRTUAL_WIDTH,'center')
end