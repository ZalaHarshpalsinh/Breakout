HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
    self.highScores = load_high_scores()
    self.scroll_offset = 0
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
    if love.keyboard.isDown('up') then
        self.scroll_offset = math.min(self.scroll_offset + 60*dt,0)
    elseif love.keyboard.isDown('down') then
        self.scroll_offset = math.max(self.scroll_offset - 60*dt,VIRTUAL_HEIGHT-40-60-((10-1)*20))
    end
end

function HighScoreState:render()
    print('High Scores','large',0,20,VIRTUAL_WIDTH,'center')
        for i=1,10,1 do
            local name = self.highScores[i] and self.highScores[i].name or '---'
            local score = self.highScores[i] and tostring(self.highScores[i].score) or '---'
            local cursorY = self.scroll_offset+60+((i-1)*20)
            if cursorY >= 60 and cursorY <= VIRTUAL_HEIGHT-40 then
                print(tostring(i)..'.','medium',30,cursorY,VIRTUAL_WIDTH,'left')
                print(name,'medium',50,cursorY,VIRTUAL_WIDTH,'left')
                print(score,'medium',0,cursorY,VIRTUAL_WIDTH-30,'right')
            end
        end
    print('Press Escape to return to the main menu..','small',0,VIRTUAL_HEIGHT-20,VIRTUAL_WIDTH,'center')
end