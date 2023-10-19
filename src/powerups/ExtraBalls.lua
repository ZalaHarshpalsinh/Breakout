ExtraBalls = Class{__includes = PowerUp}

function ExtraBalls:init(x,y)
    PowerUp.init(self,x,y)
    self.quad = gQuads['powerups']['extra_balls']
end

function ExtraBalls.should_spawn(playstate)
    local hits = playstate.hits_count
    local target = playstate.hits_target['extra_balls']
    local luck = math.random(1)
    if hits==target then --and luck then
        playstate.hits_target['extra_balls'] = playstate.hits_target['extra_balls'] + math.random(2,5)
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
    ball1.dx = math.random(-200,200)
    ball1.dy = math.random(-200,-100)
    ball2.dx = math.random(-200,200)
    ball2.dy = math.random(-200,-100)

    table.insert(playstate.balls,ball1)
    table.insert(playstate.balls,ball2)

end
