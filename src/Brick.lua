Brick = Class{}

function Brick:init(x,y,skin,tier)
    self.x = x
    self.y = y
    self.skin = skin
    self.tier = tier
    self.width = 2 * TILE_WIDTH
    self.height = TILE_HEIGHT

    self.destroyed = false
end


function Brick:render()
    if not self.destroyed then
        local index = ((self.skin-1)*4 + self.tier)
        love.graphics.draw(gTextures['main'],gQuads['bricks'][index],self.x,self.y)
    end
end

function Brick:hit()
    if self.tier > 1 then
        self.tier = self.tier - 1
    else
        self.skin = self.skin - 1
        if self.skin == 0 then
            self.destroyed = true
        end
    end
end