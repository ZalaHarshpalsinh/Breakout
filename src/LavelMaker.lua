
LevelMaker = Class{}

function LevelMaker.createMap(level)
    local bricks = {}

    local difficulty = (level%4) == 0 and 4 or level%4
    local rows = math.random(1,5)
    local columns = math.random(7,13)

    local highestSkin = difficulty 
    local highestTier = difficulty


    for y=1,rows do
        
        local applyAlternateSkin = math.random(1, 2) == 1 and true or false

        local applyGap = math.random(1, 2) == 1 and true or false

        local skin1 = math.random(1,highestSkin)
        local skin1 = math.random(1,highestSkin)
        local tier1 = math.random(1,highestTier)
        local tier2 = math.random(1,highestTier)

        local alternateFlag = false
        local gapFlag = false

        for x=1,columns do

            if(applyGap and gapFlag) then
                gapFlag = not gapFlag
                goto continue_inner
            else
                gapFlag = not gapFlag
            end

            local brick_x = 8+((x-1)*2*TILE_WIDTH)+((13-columns)*TILE_WIDTH)
            local brick_y = y*TILE_HEIGHT
            local brick_skin
            local brick_tier
            
            if(applyAlternateColor and alternateFlag) then
                brick_skin = skin2
                brick_tier = tier2
                alternateFlag = not alternateFlag
            else
                brick_skin = skin1
                brick_tier = tier1
                alternateFlag = not alternateFlag
            end
            
            local brick = Brick(brick_x,brick_y,brick_skin,brick_tier)
            table.insert(bricks,brick)
            ::continue_inner::
        end
    end

    if #bricks == 0 then
        return LevelMaker.createMap(level)
    else
        local should_lock = math.random(0,1)
        if should_lock then
            local lock_index = math.random(1,#bricks)
            bricks[lock_index].locked = true
        end
        return bricks
    end
end