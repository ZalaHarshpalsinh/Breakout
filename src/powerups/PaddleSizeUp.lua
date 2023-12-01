PaddleSizeUp = Class{__includes = PowerUp}

function PaddleSizeUp:init(x,y)
    PowerUp.init(self,x,y)
    self.quad = gQuads['powerups']['paddle_size_up']
end

function PaddleSizeUp.should_spawn(playstate)
    local score = playstate.score
    local luck = math.random(0,1)
    local target = 70

    if luck and score~=0 and score%target==0 then
        return true
    else
        return false
    end
end

function PaddleSizeUp.cause_effect(playstate)
    if playstate.paddle.size ~= 4 then
        gSounds['paddle-size-up']:play()
        playstate.paddle.size = playstate.paddle.size + 1
    end
end