--this state represents the start screen of the game. 
-- It is the entry point of the game

--inherit from BaseState
StartState = Class{__includes = BaseState}


function StartState:init()
    --array to store all the options in the menu
    self.options = {'START','HIGH SCORES','QUITE'}

    --variable to keep track of the currently highlighted option's index
    self.current_option = 1
end


--function which has the logic for updation while in Start State
function StartState:update(dt)

    --if up key is pressed decrement the option index
    if (love.keyboard.wasPressed('up')) 
    then
        self.current_option = dec_loop(self.current_option,#self.options)
    end

    --if up down is pressed increment the option index
    if(love.keyboard.wasPressed('down'))
    then
        self.current_option = inc_loop(self.current_option,#self.options)
    end
end


--function to render the Start State
function StartState:render()

    --a local variable to keep track of imaginary cursor's y coordinate
    local cursorY = VIRTUAL_HEIGHT/3;

    --TITLE
    print("BREAKOUT",'large',0,cursorY,VIRTUAL_WIDTH,'center')

    cursorY = cursorY + 40

    --instruction
    print("Select a option and press Enter",'small',0,cursorY,VIRTUAL_WIDTH,'center')

    cursorY = cursorY + 20

    --Menu
    for i=1,#self.options do

        --if this option is highlighted, change the font color 
        if(self.current_option == i) then
            love.graphics.setColor(103/255,1,1,1)
        end

        --prrint the option
        print(self.options[i],'medium',0,cursorY+((i-1)*20),VIRTUAL_WIDTH,'center')

        --reset the color
        love.graphics.setColor(1,1,1,1)
    end
end


--function to increment option index such that it loop back to 1 after crossing the last index 
function inc_loop(i,length)
    i = i + 1
    if(i>length) then i = 1 end
    return i
end

--function to decrement option index such that it loop back to last after going below the 1st index 
function dec_loop(i,length)
    i = i - 1
    if(i<1) then i = length end
    return i
end
