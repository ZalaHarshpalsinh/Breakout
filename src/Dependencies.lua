-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

--a file that containes all the global constants at a centralized location.
require 'src/CONSTANTS'

--a file that contains all the utility functions
require 'src/utility'

--a file that contains Paddle class to represent the user controllable paddle
require 'src/Paddle'

--a filr that contains Ball class to represent the ball in the game
require 'src/Ball'

require 'src/PowerUp'

require 'src/powerups/ExtraBalls'
require 'src/powerups/Life'
require 'src/powerups/Key'
require 'src/powerups/PaddleSizeUp'

require 'src/LavelMaker'
require 'src/Brick'

--a file that contains the statemachine class to smoothly transition to/from one game state from/to another, and to avoid monolithic code in one file.
require 'src/StateMachine'

--files for different game state classes that will be used by statemachine.
--each state has it's own update and render logic.

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/playState'
require 'src/states/ServeState'
require 'src/states/GameOverState'
require 'src/states/LevelCompleteState'
require 'src/states/HighScoreState'
require 'src/states/EnterHighScoreState'
require 'src/states/PaddleSelectState'