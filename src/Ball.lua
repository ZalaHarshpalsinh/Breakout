--This file contains the Ball class, that represents the actual bouncing Ball in the game that destroys the bricks

Ball = Class{}

function Ball:init()

    --Initialize the ball at 0,0 coordinates
    self.x = 0
    self.y = 0

    --initial velocity be 0
    self.dx = 0
    self.dy = 0

    --set ball's dimentions
    self.width = TILE_WIDTH/2
    self.height = TILE_HEIGHT/2

    --select the skin (color) of the ball rendomly out of 7 options
    self.skin = math.random(1,7)
end

function Ball:update(dt)

    --move ball on x
    self.x = self.x + self.dx*dt
    --move ball on y
    self.y = self.y + self.dy*dt

    --bounce off the walls

    --hit the left edge
    if self.x <=0 then
        self.x=0
        self.dx = -self.dx
    --hit the right edge
    elseif self.x>= (VIRTUAL_WIDTH  - self.width) then
        self.x = VIRTUAL_WIDTH-self.width
        self.dx = -self.dx
    --hit the ceiling
    elseif self.y <=0 then
        self.y = 0;
        self.dy = -self.dy
    end
end

function Ball:render()

    --draw the ball using the main texture and the quad of the current skin
    love.graphics.draw(gTextures['main'],gQuads['balls'][self.skin],self.x,self.y)
end


--function to reset the ball and put it in the middle of the screen with 0 velocity
function Ball:reset()
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2
    self.dx = 0
    self.dy = 0
end