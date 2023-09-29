--This file contains all the utility functions that are used throught other files


--function to print on the screen with a specified font.
--To avoid writing same lines of code again and again and to increase readablity.
function print(string,font,x,y,textBoxWidth,alignment)
    love.graphics.setFont(gFonts[font])
    love.graphics.printf(string,x,y,textBoxWidth,alignment)
end