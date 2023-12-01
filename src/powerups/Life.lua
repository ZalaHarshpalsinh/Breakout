Life = Class{__includes = PowerUp}

function Life:init(x,y)
    PowerUp.init(self,x,y)
    self.quad = gQuads['powerups']['life']
end

function Life.should_spawn(playstate)
    local score = playstate.score
    local luck = math.random(0,1)
    if score~=0 and score%100==0  and luck then
        return true
    else
        return false
    end
end

function Life.cause_effect(playstate)
    if playstate.health ~= 3 then
        gSounds['recover']:play()
        playstate.health = playstate.health + 1
    end
end

