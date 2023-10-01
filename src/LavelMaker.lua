
LevelMaker = Class{}

function LevelMaker.createMap()
    local bricks = {}

    local rows = math.random(1,6)
    local columns = math.random(5,13)

    for y=1,rows do
        for x=1,columns do
            local brick_x = 8+((x-1)*2*TILE_WIDTH)+((13-columns)*TILE_WIDTH)
            local brick_y = y*TILE_HEIGHT
            local brick = Brick(brick_x,brick_y)
            table.insert(bricks,brick)
        end
    end

    return bricks
end