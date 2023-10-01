
LevelMaker = Class{}

function LevelMaker.createMap(level)
    local bricks = {}

    local difficulty = (level%4) == 0 and 4 or level%4
    local rows = math.random(difficulty,6)
    local columns = math.random(difficulty+5,13)

    local highestSkin = difficulty 
    local highestTier = difficulty


    for y=1,rows do
        
        local skipRow = math.random(1, 2) == 1 and true or false
        if skipRow then
            goto continue_outer
        end 

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
            local brick = Brick(brick_x,brick_y)
            table.insert(bricks,brick)

            if(applyAlternateColor and alternateFlag) then
                brick.skin = skin2
                brick.tier = tier2
                alternateFlag = not alternateFlag
            else
                brick.skin = skin1
                brick.tier = tier1
                alternateFlag = not alternateFlag
            end

            table.insert(bricks,brick)

            ::continue_inner::
        end
        ::continue_outer::
    end

    if #bricks == 0 then
        return LevelMaker.createMap(level)
    else
        return bricks
    end
end