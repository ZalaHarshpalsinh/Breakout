--requiring all the dependencies
require 'src/Dependencies'


--love's load function to set up variables and settings. Called at the beginning of the game once
function love.load()
    --set filter to nearest to prevent blur and get crisp pixelated look
    love.graphics.setDefaultFilter('nearest')

    --seed the random function
    math.randomseed(os.time())

    --set the window title
    love.window.setTitle("Breakout")

    --setting up the virtual resolution along with couple of other settings using push library
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --initialize different fonts
    gFonts = {
        ['small'] = love.graphics.newFont('resources/fonts/font.ttf', 56),
        ['medium'] = love.graphics.newFont('resources/fonts/font.ttf', 112),
        ['large'] = love.graphics.newFont('resources/fonts/font.ttf', 224)
    }

    --load all the images/graphics of the game
    gTextures = {
        ['background'] = love.graphics.newImage('resources/graphics/background.png'),
        ['main'] = love.graphics.newImage('resources/graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('resources/graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('resources/graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('resources/graphics/particle.png'),
        ['manual'] = GenerateImagesManual()
    }

    --generating quads for all the sprites from the main texture, which will allow us to draw only a particular sprite from the entire sheet
    gQuads = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['bricks'] = GenerateQuadsBricks(gTextures['main']),
        ['hearts'] = GenerateQuadsHearts(gTextures['main']),
        ['arrows'] = GenerateQuads(gTextures['arrows'],24,24),
        ['powerups'] = GenerateQuadsPowerUps(gTextures['main'])
    }

    --load all the sound effects
    gSounds = {
        ['paddle-hit'] = love.audio.newSource('resources/sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('resources/sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('resources/sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('resources/sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('resources/sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('resources/sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('resources/sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('resources/sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('resources/sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('resources/sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('resources/sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('resources/sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('resources/sounds/pause.wav', 'static'),
        ['music'] = love.audio.newSource('resources/sounds/music.wav', 'static')
    }

    --creating a state machine that will handle the state trasition
    gStateMachine = StateMachine{
        ['BaseState'] = function() return BaseState() end,
        ['StartState'] = function() return StartState() end,
        ['PlayState'] = function() return PlayState() end,
        ['ServeState'] = function() return ServeState() end,
        ['LevelCompleteState'] = function() return LevelCompleteState() end,
        ['GameOverState'] = function() return GameOverState() end,
        ['HighScoreState'] = function() return HighScoreState() end,
        ['EnterHighScoreState'] = function() return EnterHighScoreState() end,
        ['PaddleSelectState'] = function() return PaddleSelectState() end,
        ['ManualState'] = function() return ManualState() end
    }

    --setting the current state to start state at the start of the game
    gStateMachine:change('StartState')

    --a table that is used to keep track of the keys that have been pressed by the user in current frame
    love.keyboard.keysPressed = {}
    love.keyboard.pressedAlphabet = nil
end


--love's update function to update each frame
function love.update(dt)

    --using state machine to update the current state
    gStateMachine:update(dt)

    --reset keys pressed for next frame
    love.keyboard.keysPressed = {}
    love.keyboard.alphaPressed = false
end

--love's draw function to draw each frame
function love.draw()

    --start applying virtual resolution
    push:start()
    
    --drawing background regardless of state, i.e. in each state
    love.graphics.draw(gTextures['background'],0,0,0,
        --Setting scaleX and scaleY values to fit the image to virtual resolution
        VIRTUAL_WIDTH/(gTextures['background']:getWidth()-1),
        VIRTUAL_HEIGHT/(gTextures['background']:getHeight()-1))

    --using state machine to render the current state
    gStateMachine:render()

    --displaying FPS
    displayFPS()

    --stop applying virtual resolution
    push:finish()
end


--function to handle resizing of the window
function love.resize(w,h)
    --calling out push to handle resizing
    push:resize(w,h)
end

--a function which is called when a key is pressed
function love.keypressed(key)
    if #key==1 and string.match(key,'%l') then
        love.keyboard.alphaPressed = true
        love.keyboard.pressedAlphabet = key
    end
    --marking input key in out keysPressed table
    love.keyboard.keysPressed[key] = true
end

--creating a function to look at keysPressed table and tell if given key is pressed or not
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end




