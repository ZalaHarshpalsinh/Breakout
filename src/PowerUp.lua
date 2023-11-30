PowerUp = Class{}

function PowerUp:init(x,y)
    self.x = x
    self.y = y
    self.dy = POWERUP_SPEED
    self.width = TILE_WIDTH * SCALE_X
    self.height = TILE_HEIGHT * SCALE_Y
end

function PowerUp.should_spawn(game_paras)
end

function PowerUp.cause_effect(game_paras)
end

function PowerUp:update(dt)
    self.y = self.y + (dt * self.dy)
end

function PowerUp:render()
    love.graphics.draw(gTextures['main'],self.quad,self.x,self.y,0,SCALE_X,SCALE_Y)
end