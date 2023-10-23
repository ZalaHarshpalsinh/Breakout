--This file contains all the utility functions that are used throught other files


--Function to check if ball collides with given object
function collides(object1,object2)

    --Ball is completely right or left to the object, then return false
    if object1.x > object2.x + object2.width or object2.x > object1.x+object1.width then
        return false
    end

    --Ball is completely above or below the object, then return false
    if object1.y > object2.y + object2.height or object2.y > object1.y+object1.height then
        return false
    end

    --if none of the above is true, then collision has happened.return true
    return true
end


--function to print on the screen with a specified font.
--To avoid writing same lines of code again and again and to increase readablity.
function print(string,font,x,y,textBoxWidth,alignment)
    love.graphics.setFont(gFonts[font])
    love.graphics.printf(string,x,y,textBoxWidth,alignment)
end


--This function, given an atlas (a sprite sheet) and the width and height of the tiles therein, splits the texture into all the quads by simply dividing it evenly
function GenerateQuads(atlas,tileWidth,tileHeight)

    --number of quads in each row
    local columns = atlas:getWidth() / tileWidth

    --number of quads in each column
    local rows = atlas:getHeight() / tileHeight

    --counter to keep track of next quad's index ad well as current number of quads
    local counter = 1

    --array to store all the quads
    local quads = {}

    --for each row
    for y=0,rows-1 do
        --for each column
        for x=0,columns-1 do

            --generate the quad and store it
            quads[counter] = love.graphics.newQuad(x*tileWidth, y *tileHeight, tileWidth, tileHeight, atlas:getDimensions())

            --increment the counter
            counter = counter + 1
        end
    end

    return quads
end

--A function to slice the tables
function table.slice(tbl,first,last,step)

    --array to store the slices
    local slices = {}

    --slice the given table
    for i=first or 1, last or #tbl, step or 1 do
        slices[#slices+1] = tbl[i]
    end

    return slices
end


function GenerateQuadsBricks(atlas)
    local bricks =  table.slice(GenerateQuads(atlas,2*TILE_WIDTH,TILE_HEIGHT),1,16,1)
    table.insert(bricks,love.graphics.newQuad(10*TILE_WIDTH,3*TILE_HEIGHT,2*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions()))
    return bricks
end

function GenerateQuadsPowerUps(atlas)
    local powerups = {}

    powerups['extra_balls'] = love.graphics.newQuad(7*TILE_WIDTH,12*TILE_HEIGHT,TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
    powerups['key'] = love.graphics.newQuad(9*TILE_WIDTH,12*TILE_HEIGHT,TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
    powerups['paddle_size_up'] = love.graphics.newQuad(4*TILE_WIDTH,12*TILE_HEIGHT,TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
    powerups['life'] = love.graphics.newQuad(2*TILE_WIDTH,12*TILE_HEIGHT,TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())

    return powerups
end

--This function takes the whole atlas (sprite sheet) and cuts out and reuturns the different Paddle shrites (Or to say more precisely, their quads) from it.
function GenerateQuadsPaddles(atlas)

    --In a nutshell: coordinates for the scissors
    local x = 0
    local y = 4 * TILE_HEIGHT -- There are 4 block above the point from where the paddles start 

    --counter to count and maintain index for paddles
    local counter = 1

    --Array to store the paddles's quads
    local paddles = {}

    --iterate over all 4 colours of paddles
    for i=0,3 do

        --smallest paddle
        paddles[counter] = love.graphics.newQuad(x,y,2*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1
        --move scissors to left
        x = x + 2 * TILE_WIDTH

        --medium paddle
        paddles[counter] = love.graphics.newQuad(x,y,4*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1
        --move scissors to left
        x = x + 4 * TILE_WIDTH

        --large paddle
        paddles[counter] = love.graphics.newQuad(x,y,6*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1
        --move scissors to left
        x = 0 

        --huge paddle
        paddles[counter] = love.graphics.newQuad(x,y+TILE_HEIGHT,8*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1

        --move the scissors to the next colour of paddle
        x = 0
        y = y + 2* TILE_HEIGHT
    end

    return paddles
end

--This function takes the whole atlas (sprite sheet) and cuts out and reuturns the different Balls' shrites (Or to say more precisely, their quads) from it.
function GenerateQuadsBalls(atlas)
    
    --In a nutshell:  coordinates for the scissors
    local x = 6*TILE_WIDTH --There are 6 block left to  the point from where the balls start
    local y = 3 * TILE_HEIGHT -- There are 3 block above the point from where the balls start

    --counter to count and maintain index for balls
    local counter = 1

    --Array to store the balls' quads
    local balls = {}

    --Iterate over 4 balls in the first row
    for i=0,3 do
        balls[counter] = love.graphics.newQuad(x,y,TILE_WIDTH/2,TILE_HEIGHT/2,atlas:getDimensions())
        counter = counter + 1
        x = x + TILE_WIDTH/2
    end

    --set scissors to next row of balls
    x = 6 * TILE_WIDTH
    y = 3 * TILE_HEIGHT + TILE_HEIGHT/2

    --Iterate over 3 balls in the second row
    for i=0,2 do
        balls[counter] = love.graphics.newQuad(x,y,TILE_WIDTH/2,TILE_HEIGHT/2,atlas:getDimensions())
        counter = counter + 1
        x = x + TILE_WIDTH/2
    end

    return balls
end

function GenerateQuadsHearts(atlas)
    local hearts = {}

    local x = 8 * TILE_WIDTH
    local y = 3 * TILE_HEIGHT

    hearts[0] = love.graphics.newQuad(x,y,TILE_WIDTH/2 + 2,TILE_HEIGHT/2 + 5,atlas:getDimensions())
    x = x + TILE_WIDTH/2 + 2
    hearts[1] = love.graphics.newQuad(x,y,TILE_WIDTH/2 + 2,TILE_HEIGHT/2 + 5,atlas:getDimensions())

    return hearts
end

--function to display FPS on the screen
function displayFPS()
    --set color to green
    love.graphics.setColor(0,1,0,1)
    print('FPS: ' .. tostring(love.timer.getFPS()),'small', 5 , 5,VIRTUAL_WIDTH,'left')
    love.graphics.setColor(1,1,1,1)
end

function renderHealth(health)
    local health_x = VIRTUAL_WIDTH - 200

    for i=1,health do
        love.graphics.draw(gTextures['main'],gQuads['hearts'][0],health_x,5)
        health_x  = health_x + TILE_WIDTH/2 + 3
    end

    for i=1,3 - health do
        love.graphics.draw(gTextures['main'],gQuads['hearts'][1],health_x,5)
        health_x  = health_x + TILE_WIDTH/2 + 3
    end
end

function renderScore(score)
    print('Score: ' .. tostring(score),'small', VIRTUAL_WIDTH - 100,5,100,'right')
end

function load_high_scores()
    love.filesystem.setIdentity('breakout')

    if not love.filesystem.getInfo('breakout.lst') then
        love.filesystem.write('breakout.lst','harshpal\n0\n')
    end

    local scores = {}
    local is_name = true
    local name = ""
    for line in love.filesystem.lines('breakout.lst') do
        if is_name then
            name = line
        else
            scores[#scores+1] = {name = name, score = tonumber(line)}
        end
        is_name = not is_name
    end
    
    return scores
end