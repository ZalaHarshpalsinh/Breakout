Brick = Class{}

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    }
}

function Brick:init(x,y,skin,tier)
    self.x = x
    self.y = y
    self.skin = skin
    self.tier = tier
    self.width = 2 * TILE_WIDTH
    self.height = TILE_HEIGHT
    self.destroyed = false

    self.particle_system = love.graphics.newParticleSystem(gTextures['particle'],20)

    self.particle_system:setEmissionArea('normal',10,10)

    self.particle_system:setParticleLifetime(1,2)

    self.particle_system:setLinearAcceleration(-20,50,20,100)
end

function Brick:update(dt)
    self.particle_system:update(dt)
end


function Brick:render()

    if not self.destroyed then
        local index = ((self.skin-1)*4 + self.tier)
        love.graphics.draw(gTextures['main'],gQuads['bricks'][index],self.x,self.y)
    end
    love.graphics.draw(self.particle_system,self.x+self.width/2,self.y+self.height/2)

end

function Brick:hit()

    self.particle_system:setColors(
        paletteColors[self.skin]['r']/255,
        paletteColors[self.skin]['g']/255,
        paletteColors[self.skin]['b']/255,
        (64*self.tier-1)/255,
        paletteColors[self.skin]['r']/255,
        paletteColors[self.skin]['g']/255,
        paletteColors[self.skin]['b']/255,
        0
    )
    self.particle_system:emit(20)

    if self.tier > 1 then
        self.tier = self.tier - 1
    else
        self.skin = self.skin - 1
        if self.skin == 0 then
            self.destroyed = true
        end
    end
end