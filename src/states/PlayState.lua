--This state represents the active play part of the game 

--inherit from BaseState
PlayState = Class{__includes = BaseState}

function PlayState:init()
    --Create a Paddle
    self.Paddle = Paddle()

    --bool to know if game is paused or not
    self.paused = false
end

function PlayState:update(dt)

    --if user pressed space pause/resume the game
    if love.keyboard.wasPressed('space') then
        self.paused = not self.paused
    end
    
    --Update the paddle only if game is resumed
    if(self.paused==false)then  
        --update the paddle
        self.Paddle:update(dt)
    end

    --if user presses escape take him to menu
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('StartState')
    end
end

function PlayState:render()

    --render the paddle 
    self.Paddle:render()

    --if game is paused, display Pause text
    if self.paused then
        print('PAUSED','large',0,VIRTUAL_HEIGHT/2-16,VIRTUAL_WIDTH,'center')
    end
end

