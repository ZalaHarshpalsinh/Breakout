ManualState = Class{__includes = BaseState}

function ManualState:init()
    self.scroll_offset = 0
    self.page_names = {'Basic_rules','Controlls','Powerups'}
    self.current_page = 1
    self.photo_index = 1
    self.content_box = 
    {
        x = 200,
        y = 200,
        width = VIRTUAL_WIDTH-400,
        height = VIRTUAL_HEIGHT-300
    }

    self.scale_x = self.content_box.width/gTextures['manual']['Basic_rules'][1]:getWidth()
    self.scale_y = self.content_box.height/gTextures['manual']['Basic_rules'][1]:getHeight()
end

function ManualState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.current_page==1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.current_page = self.current_page - 1
            self.photo_index=1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.current_page==#self.page_names then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.current_page = self.current_page + 1
            self.photo_index=1
        end
    elseif love.keyboard.wasPressed('up') then
        if self.photo_index==1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.photo_index = self.photo_index - 1
        end
    elseif love.keyboard.wasPressed('down') then
        if self.photo_index==#gTextures['manual'][self.page_names[self.current_page]] then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.photo_index = self.photo_index + 1
        end
    elseif love.keyboard.wasPressed('escape') then
        gSounds['back']:play()
        gStateMachine:change('StartState')
    end
end

function ManualState:render()
    if self.current_page == 1 then
        love.graphics.setColor(1,1,1,0.3)
    end
    love.graphics.draw(gTextures['arrows'],gQuads['arrows'][1],20,VIRTUAL_HEIGHT/2,0,SCALE_X,SCALE_Y)
    love.graphics.setColor(1,1,1,1)

    if self.current_page == #self.page_names then
        love.graphics.setColor(1,1,1,0.3)
    end
    love.graphics.draw(gTextures['arrows'],gQuads['arrows'][2],VIRTUAL_WIDTH-(20+(24*SCALE_X)),VIRTUAL_HEIGHT/2,0,SCALE_X,SCALE_Y)
    love.graphics.setColor(1,1,1,1)

    -- love.graphics.setColor(1,0,0,0.6)
    -- love.graphics.rectangle('fill',self.content_box.x,self.content_box.y,self.content_box.width,self.content_box.height)
    -- love.graphics.setColor(1,1,1,1)

    local cursor = {x=0,y=10}
    print(self.page_names[self.current_page],'medium',cursor.x,cursor.y,VIRTUAL_WIDTH,'center')

    cursor.x = self.content_box.x+10
    cursor.y = self.content_box.x+10
    love.graphics.draw(gTextures['manual'][self.page_names[self.current_page]][self.photo_index],self.content_box.x,self.content_box.y,0,self.scale_x,self.scale_y)
end