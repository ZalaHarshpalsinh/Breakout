--This is a file that stores all the global constants required by other moduls, at a centralized space


--Size of the actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--Size I consider while coding, and will be scaled to match the actual window_width/height, through push library.
VIRTUAL_WIDTH = 2667
VIRTUAL_HEIGHT = 1500

--Scale factor for all the images
SCALE_X = VIRTUAL_WIDTH/432
SCALE_Y = VIRTUAL_HEIGHT/243

--Width and Height of a single tile in the spriteSheet
TILE_WIDTH = 16
TILE_HEIGHT = 16

--speed of the paddle
PADDLE_SPEED = 300*SCALE_X

POWERUP_SPEED = 50*SCALE_Y