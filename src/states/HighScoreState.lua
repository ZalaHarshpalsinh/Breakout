HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
    self.highScores = load_high_scores()
    self.scroll_offset = 0
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gSounds['back']:play()
        gStateMachine:change('StartState')
    end
    if love.keyboard.isDown('up') then
        self.scroll_offset = math.min(self.scroll_offset + 420*dt,0)
    elseif love.keyboard.isDown('down') then
        self.scroll_offset = math.max(self.scroll_offset - 420*dt,VIRTUAL_HEIGHT-280-420-((10-1)*140))
    end
end

function HighScoreState:render()
    print('High Scores','large',0,140,VIRTUAL_WIDTH,'center')
        for i=1,10,1 do
            local name = self.highScores[i] and self.highScores[i].name or '---'
            local score = self.highScores[i] and tostring(self.highScores[i].score) or '---'
            local cursorY = self.scroll_offset+420+((i-1)*140)
            if cursorY >= 420 and cursorY <= VIRTUAL_HEIGHT-280 then
                print(tostring(i)..'.','medium',210,cursorY,VIRTUAL_WIDTH,'left')
                print(name,'medium',350,cursorY,VIRTUAL_WIDTH,'left')
                print(score,'medium',0,cursorY,VIRTUAL_WIDTH-210,'right')
            end
        end
    print('Press Escape to return to the main menu..','small',0,VIRTUAL_HEIGHT-140,VIRTUAL_WIDTH,'center')
end