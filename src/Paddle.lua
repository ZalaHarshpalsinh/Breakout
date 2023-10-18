--This file contains the Paddle class, which represents the user controllable paddle of the game

Paddle = Class{}


function Paddle:init(skin)

    --size of the paddle, which also denotes the half the number of tiles in the paddle, as each size addes 2 tiles in the paddle
    self.size = 2

    --skin colour of the paddle, used to find the correct index for the paddle in the gQuads['paddles'] table
    self.skin = skin

    --Paddle will spawn in the middle of the game world,in the bottom
    self.x = VIRTUAL_WIDTH/2 - 32
    self.y = VIRTUAL_HEIGHT - 2*TILE_HEIGHT

    --start with no velocity
    self.dx = 0

    --Dimensions of the paddle 
    self.width = (self.size*2*TILE_WIDTH)
    self.height = TILE_HEIGHT
end

function Paddle:update(dt)

    --check for input and  change the velocity of paddle accordingly
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    --Clapping the x corrdinate of paddle such that paddle does not go out of the screen
    self.x = math.min(VIRTUAL_WIDTH-self.width,math.max(0,self.x + self.dx * dt))
end

function Paddle:render()

    --drawing the Paddle using main spritesheet texture and pre-claculated quads 
    love.graphics.draw(gTextures['main'],gQuads['paddles'][(self.skin-1)*4 + self.size],self.x,self.y)
end