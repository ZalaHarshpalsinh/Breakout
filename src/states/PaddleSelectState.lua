PaddleSelectState = Class{__includes = BaseState}

function PaddleSelectState:init()
    self.currentPaddle = 1
end

function PaddleSelectState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.currentPaddle ~= 1 then
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.currentPaddle ~= 4 then
            self.currentPaddle = self.currentPaddle + 1
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        local bricks = LevelMaker.createMap(1)
        gStateMachine:change('ServeState',{
            paddle = Paddle(self.currentPaddle),
            bricks = bricks,
            health = 3,
            score = 1000,
            level = 1,
            hits_count = 0,
            hits_target = 
            {
                ['extra_balls'] = math.random(5,10),
                ['key'] = #bricks/2
            },
            active_bricks = #bricks
        })
    elseif love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
end

function PaddleSelectState:render()
    print('Select a Paddle','medium',0,210,VIRTUAL_WIDTH,'center')
    print('(Press Enter to continue)','small',0,420,VIRTUAL_WIDTH,'center')
    
    if self.currentPaddle == 1 then
        love.graphics.setColor(1,1,1,0.3)
    end
    love.graphics.draw(gTextures['arrows'],gQuads['arrows'][1],350,VIRTUAL_HEIGHT/2,0,SCALE_X,SCALE_Y)
    love.graphics.setColor(1,1,1,1)

    if self.currentPaddle == 4 then
        love.graphics.setColor(1,1,1,0.3)
    end
    love.graphics.draw(gTextures['arrows'],gQuads['arrows'][2],VIRTUAL_WIDTH-350-168,VIRTUAL_HEIGHT/2,0,SCALE_X,SCALE_Y)
    love.graphics.setColor(1,1,1,1)

    love.graphics.draw(gTextures['main'],gQuads['paddles'][(self.currentPaddle-1)*4 + 2],VIRTUAL_WIDTH/2-2*TILE_WIDTH*SCALE_X,VIRTUAL_HEIGHT/2,0,SCALE_X,SCALE_Y)
end