--This file contains all the utility functions that are used throught other files


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
            quads[counter] = love.graphics.newQuad(x*tileWidth, y *tileHeight, tileWidth, tileHeight, atlas:getDimentions())

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


--This function takes the whole atlas (sprite sheet) and cuts out and reuturns the different Paddle shrites (Or to say more precisely, their quads) from it.
function GenerateQuadsPaddles(atlas)

    --In a nutshell: x coordinates for the scissors
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

        --medium paddle
        paddles[counter] = love.graphics.newQuad(x + 2*TILE_WIDTH,y,4*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1

        --large paddle
        paddles[counter] = love.graphics.newQuad(x + 6*TILE_WIDTH,y,6*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1

        --huge paddle
        paddles[counter] = love.graphics.newQuad(x + 12*TILE_WIDTH,y+TILE_HEIGHT,8*TILE_WIDTH,TILE_HEIGHT,atlas:getDimensions())
        counter = counter + 1

        --move the scissors to the next colour of paddle
        y = y + 2* TILE_HEIGHT
    end

    return paddles
end