push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'states/CountDownState'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll=0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

local pipePairs = {}

local timer = 0
local lastY = -PIPE_HEIGHT + math.random(80) + 20

scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('FLAPPY BIRD')

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf',28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountDownState() end,
    }
    gStateMachine:change('title')

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['pause'] = love.audio.newSource('pause.wav', 'static'),

        -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }

    -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()

    math.randomseed(os.time())

    love.keyboard.keysPressed = {}

end
function love.resize(w,h)
        push:resize(w,h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true    
    if key == 'escape' then
            love.event.quite()
        end
    end
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end


function love.update(dt)
    if scrolling then
            backgroundScroll = (backgroundScroll+BACKGROUND_SCROLL_SPEED*dt)
                %BACKGROUND_LOOPING_POINT
            
            groundScroll = (groundScroll+GROUND_SCROLL_SPEED*dt)
                %VIRTUAL_WIDTH
    end
            

    gStateMachine:update(dt)

  love.keyboard.keysPressed = {}
  love.mouse.buttonsPressed = {}
end
        
    

function love.draw()
        push:start()
        love.graphics.draw(background, -backgroundScroll, 0)
        
        gStateMachine:render()

        love.graphics.draw(ground, -backgroundScroll, VIRTUAL_HEIGHT-16)

        push:finish()
end
