ManualState = Class{__includes = BaseState}

function ManualState:init()
    self.scroll_offset = 0
    self.pages = {
        [1] =  function() self:print_page_1() end,
        [2] = function() self:print_page_2() end,
        [3] = function() self:print_page_3() end
    }
    self.current_page = 1
end

function ManualState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.current_page==1 then

        else
            self.current_page = self.current_page - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.current_page==#self.pages then
            
        else
            self.current_page = self.current_page + 1
        end
    elseif love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
end

function ManualState:render()
    self.pages[self.current_page]()
end

function ManualState.print_page_1()
    print('Basic Rules','medium',0,10,VIRTUAL_WIDTH,'center')
end

function ManualState.print_page_2()
    print('Controlls','medium',0,10,VIRTUAL_WIDTH,'center')
end


function ManualState.print_page_3()
    print('Powerups','medium',0,10,VIRTUAL_WIDTH,'center')
end