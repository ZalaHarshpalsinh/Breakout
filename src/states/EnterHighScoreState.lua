EnterHighScoreState = Class{__includes = BaseState}

function EnterHighScoreState:enter(paras)
    self.new_score = paras.new_score
    self.new_score_index = paras.new_score_index
    self.highScores = paras.highScores
    self.name = ''
end

function EnterHighScoreState:update(dt)
    if love.keyboard.alphaPressed then
        if #self.name <= 20 then
            self.name = self.name .. love.keyboard.pressedAlphabet
        else
            --sound
        end
    end

    if love.keyboard.wasPressed('backspace') then
        if #self.name >=1 then
            self.name = self.name:sub(1,-2)
        else
            --sound
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if #self.name ~= 0 then
            for i=#self.highScores+1,self.new_score_index+1,-1 do
                self.highScores[i] = self.highScores[i-1]
            end
            self.highScores[self.new_score_index] = {name= self.name, score = self.new_score}
            local new_scores_data = ""
            for i=1,math.min(#self.highScores,10) do
                new_scores_data = new_scores_data .. self.highScores[i].name .. '\n'
                new_scores_data = new_scores_data .. tostring(self.highScores[i].score) .. '\n'
            end
            love.filesystem.write('breakout.lst',new_scores_data)
            gStateMachine:change('StartState')
        else
            --sound
        end
    end
end

function EnterHighScoreState:render()
    local cursorY = 20
    print('New High Score','large',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 60
    print('Enter your name:','medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 40
    love.graphics.setColor(129/255, 31/255, 204/255 , 0.65)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-100,cursorY,200,25)
    cursorY = cursorY + 5
    love.graphics.setColor(1,1,1,1)
    print(self.name,'medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 40
    love.graphics.setColor(129/255, 31/255, 204/255 , 1)
    print('Your score: '..self.new_score,'medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 40
    love.graphics.setColor(1,1,1,1)
    print('Press enter when you are finished.','small',0,cursorY,VIRTUAL_WIDTH,'center')
end