GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.highScores = load_high_scores()
end

function GameOverState:enter(paras)
    self.score = paras.score

    self.is_new_high_score = #self.highScores < 10
    self.highscore_index = #self.highScores + 1

    for i=#self.highScores,1,-1 do
        local score = self.highScores[i].score

        if self.score>=score then
            self.is_new_high_score = true
            self.highscore_index = i
        end
    end
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.is_new_high_score then
            gStateMachine:change('EnterHighScoreState',{
                new_score = self.score,
                new_score_index = self.highscore_index,
                highScores = self.highScores
            })
        else
            gStateMachine:change('StartState')
        end
    end
end

function GameOverState:render()
    print('GAME OVER','large',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    print('Final Score: ' .. tostring(self.score), 'medium' , 0, VIRTUAL_HEIGHT/2 ,VIRTUAL_WIDTH,'center')
    print('Press Enter!', 'medium',0,VIRTUAL_HEIGHT/2 + 40, VIRTUAL_WIDTH,'center')
end