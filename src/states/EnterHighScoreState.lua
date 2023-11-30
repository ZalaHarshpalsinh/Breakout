EnterHighScoreState = Class{__includes = BaseState}

function EnterHighScoreState:enter(paras)
    self.new_score = paras.new_score
    self.new_score_index = paras.new_score_index
    self.highScores = paras.highScores
    self.name = ''
    self.cursor_char = '_'
    self.cursor = self.cursor_char
    self.timer = 0
    self.blink_time = 0.4
end

function EnterHighScoreState:update(dt)
    self.timer = self.timer + dt
    if(self.timer > self.blink_time) then
        self.cursor = self.cursor == '' and self.cursor_char or ''
        self.timer = 0
    end

    if love.keyboard.alphaPressed then
        if #self.name < 20 then
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

    if love.keyboard.wasPressed('escape') then
       gStateMachine:change('StartState')
    end
end

function EnterHighScoreState:render()
    local cursorY = 140
    print('New High Score','large',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 420
    print('Enter your name:','medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 280
    love.graphics.setColor(129/255, 31/255, 204/255 , 0.65)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-750,cursorY,1500,175)
    cursorY = cursorY + 35
    love.graphics.setColor(1,1,1,1)
    print(self.name..self.cursor,'medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 280
    love.graphics.setColor(129/255, 31/255, 204/255 , 1)
    print('Your score: '..self.new_score,'medium',0,cursorY,VIRTUAL_WIDTH,'center')
    cursorY = cursorY + 280
    love.graphics.setColor(1,1,1,1)
    print('Press enter when you are finished.','small',0,cursorY,VIRTUAL_WIDTH,'center')
end