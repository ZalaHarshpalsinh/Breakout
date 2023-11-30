ExtraBalls = Class{__includes = PowerUp}

function ExtraBalls:init(x,y)
    PowerUp.init(self,x,y)
    self.quad = gQuads['powerups']['extra_balls']
end

function ExtraBalls.should_spawn(playstate)
    local hits = playstate.hits_count
    local target = playstate.hits_target['extra_balls']
    local luck = math.random(0,1)
    if hits==target and luck then
        playstate.hits_target['extra_balls'] = playstate.hits_target['extra_balls'] + math.random(5,10)
        return true
    else
        return false
    end
end

function ExtraBalls.cause_effect(playstate)
    local paddle = playstate.paddle
    
    local ball1 = Ball()
    local ball2 = Ball()
    ball1.x = paddle.x + (paddle.width/2) - (ball1.width/2)
    ball2.x = paddle.x + (paddle.width/2) - (ball1.width/2)
    ball1.y = paddle.y - ball1.height
    ball2.y = paddle.y - ball1.height
    ball1.dx = math.random(-200,200) * SCALE_X
    ball1.dy = math.random(-200,-100) * SCALE_Y 
    ball2.dx = math.random(-200,200) * SCALE_X
    ball2.dy = math.random(-200,-100) * SCALE_Y

    table.insert(playstate.balls,ball1)
    table.insert(playstate.balls,ball2)

end
