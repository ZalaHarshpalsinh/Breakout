LevelCompleteState = Class{__includes = BaseState}

function LevelCompleteState:enter(paras)
    self.level = paras.level
    self.paddle = paras.paddle
    self.health = paras.health
    self.score = paras.score
end

function LevelCompleteState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gSounds['confirm']:play()
        local bricks =  LevelMaker.createMap(self.level+1)
        
        gStateMachine:change('ServeState',{
            paddle = self.paddle,
            score = self.score,
            health = self.health,
            bricks = bricks,
            level = self.level+1,
            hits_count = 0,
            hits_target = 
            {
                ['extra_balls'] = math.random(5,10),
                ['key'] = math.floor(#bricks/2)
            },
            active_bricks = #bricks
        })
    end
    if love.keyboard.wasPressed('escape') then
        gSounds['back']:play()
        gStateMachine:change('StartState')
    end
end

function LevelCompleteState:render()
    print('Level '..self.level..' Complete','large',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    print('Press enter','medium',0,VIRTUAL_HEIGHT/3+420,VIRTUAL_WIDTH,'center')
    self.paddle:render()
    renderHealth(self.health)
    renderScore(self.score)
end
