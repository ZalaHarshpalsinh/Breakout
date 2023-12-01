Key = Class{__includes = PowerUp}

function Key:init(x,y)
    PowerUp.init(self,x,y)
    self.quad = gQuads['powerups']['key']
end

function Key.should_spawn(playstate)
    local hits = playstate.hits_count
    local target = playstate.hits_target['key']
    local locked_brick_index = playstate.locked_brick_index
    
    if playstate.active_bricks==1 then
        playstate.hits_target['key'] = playstate.hits_count + 1
    end

    if  locked_brick_index~=0 and hits==target then
        if playstate.active_bricks~=1 then
            playstate.hits_target['key'] = playstate.hits_target['key'] + math.random(2,5)
        end
        return true
    else
        return false
    end
end

function Key.cause_effect(playstate)
    if playstate.locked_brick_index~=0 then
        gSounds['key']:play()
        playstate.bricks[playstate.locked_brick_index].locked = false
        playstate.locked_brick_index = 0
    end
end