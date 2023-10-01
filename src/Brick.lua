Brick = Class{}

function Brick:init(x,y)
    self.x = x
    self.y = y

    self.width = 2 * TILE_WIDTH
    self.height = TILE_HEIGHT

    self.skin = 1
    self.tier = 1

    self.destroyed = false
end


function Brick:render()
    if not self.destroyed then
        local index = ((self.skin-1)*4 + self.tier)
        love.graphics.draw(gTextures['main'],gQuads['bricks'][index],self.x,self.y)
    end
end