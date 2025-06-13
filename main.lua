-- main.lua
-- author: Eric Gonzalez
-- 05/31/24

io.stdout:setvbuf("no")

math.randomseed(os.time())

-- require calls to different files
require "vector"
require "card"
require "player"
require "location"
require "grabber"
require "board"

function love.load()
  
  music = love.audio.newSource('Sound/fantasyBGM.mp3', 'stream')
  music:setLooping(true)
  music:play()
  
  buttonSFX = love.audio.newSource('Sound/buttonSFX.mp3', 'static')
  
  -- color definitions
  white = {1, 1, 1, 1}
  black = {0, 0, 0, 1}
  red = {0.8, 0, 0, 1}
  green = {0, 0.7, 0.2, 1}
  blue = {0.35, 0.55, 7, 1}
  pink = {0.5, 0.0, 0.5, 1}
  tan = {0.61, 0.52, 0.41, 1}
  yellow = {1, 1, 0, 1}
  
  smallFont = love.graphics.newFont(16)
  largeFont = love.graphics.newFont(24)
  hugeFont = love.graphics.newFont(100)
  titleFont = love.graphics.newFont(80)
  mediumFont = love.graphics.newFont(32)
  
  love.graphics.setLineWidth(3)
  
  screenBounds = Vector(1400, 860)
  halfCardWidth = 45
  halfCardHeight = 65
  
  love.window.setMode(screenBounds.x, screenBounds.y)
  love.graphics.setBackgroundColor(tan)
  love.window.setTitle("Mythological Showdown v0.5")
  
  -- Game state system
  gameState = "title" -- can be "title", "playing", or "gameOver"
  titlePulse = 0 -- for pulsing effect
  creditsScroll = 0 -- for scrolling credits
  
  initializeGame()
end

function initializeGame()
  -- make p1 and p2 objects
  p1 = PlayerClass:new("p1")
  p2 = PlayerClass:new("p2") -- this is AI
  
  --shuffle cards
  p1:shuffle()
  p2:shuffle()
  
  -- add all cards to each player's deck
  for _, card in ipairs(p1.cards) do
    p1.deck:addCard(card)
  end
  
  for _, card in ipairs(p2.cards) do
    p2.deck:addCard(card)
  end
  
  -- remove three cards from each player's deck and add it to their hand
  p1:drawFromDeck(3)
  p2:drawFromDeck(3)
  
  -- initialize the locations
  locations = {}
  location1 = LocationClass:new("Location 1", 50, screenBounds.y/2 + 5)
  location2 = LocationClass:new("Location 2", 500, screenBounds.y/2 + 5)
  location3 = LocationClass:new("Location 3", 950, screenBounds.y/2 + 5)
  table.insert(locations, location1)
  table.insert(locations, location2)
  table.insert(locations, location3)
  
  -- initialize the grabber and board
  grabber = GrabberClass:new()
  board = BoardClass:new()
  
  -- Reset credits scroll
  creditsScroll = 0
end

function love.update(dt)
  if gameState == "title" then
    titlePulse = titlePulse + dt * 3 -- Speed of pulse
  elseif gameState == "playing" then
    grabber:update()
    board:update()
    
    -- Check if game is over
    if board.state == "gameOver" then
      gameState = "gameOver"
    end
  end
end

function love.draw()
  if gameState == "title" then
    drawTitleScreen()
  elseif gameState == "playing" then
    drawGameScreen()
  elseif gameState == "gameOver" then
    drawGameOverScreen()
  end
end

function drawTitleScreen()
  -- Draw title
  love.graphics.setColor(yellow)
  love.graphics.setFont(titleFont)
  love.graphics.printf("MYTHICAL CARD", 0, 200, screenBounds.x, "center")
  love.graphics.printf("SHOWDOWN", 0, 300, screenBounds.x, "center")
  
  -- Pulsing "Press to Start" button
  local pulseAlpha = 0.5 + 0.5 * math.sin(titlePulse)
  love.graphics.setColor(white[1], white[2], white[3], pulseAlpha)
  love.graphics.setFont(mediumFont)
  love.graphics.printf("Press Any Key to Start", 0, 500, screenBounds.x, "center")
  
  -- Version info
  love.graphics.setColor(white)
  love.graphics.setFont(smallFont)
  love.graphics.printf("v1.0", screenBounds.x - 100, screenBounds.y - 30, 100, "center")
end

function drawGameScreen()
  p1.deck:draw()
  p2.deck:draw()
  
  p1.hand:draw()
  p2.hand:draw()
  
  p1.discardPile:draw()
  p2.discardPile:draw()
  
  location1:draw()
  location2:draw()
  location3:draw()
  
  for _, card in ipairs(p1.cards) do
    card:draw()
  end
  
  for _, card in ipairs(p2.cards) do
    card:draw()
  end
  
  board:draw()
end

function drawGameOverScreen()
  -- game result
  love.graphics.setColor(yellow) 
  love.graphics.setFont(love.graphics.newFont(150))
  if p1.points >= p2.points then
    love.graphics.printf("You Won!", 0, 200, screenBounds.x, "center")
  else
    love.graphics.printf("You Lost!", 0, 200, screenBounds.x, "center")
  end
  
  -- final scores
  love.graphics.setFont(mediumFont)
  love.graphics.printf("Final Score: " .. p1.points .. " - " .. p2.points, 0, 380, screenBounds.x, "center")
  
  -- credits
  love.graphics.setFont(largeFont)
  local creditY = 500
  
  love.graphics.printf("CREDITS", 0, creditY, screenBounds.x, "center")
  love.graphics.printf("Created by", 0, creditY + 60, screenBounds.x, "center")
  love.graphics.printf("Eric Gonzalez", 0, creditY + 100, screenBounds.x, "center")
  love.graphics.printf("and", 0, creditY + 140, screenBounds.x, "center")
  love.graphics.printf("Ayush Bandopadhyay", 0, creditY + 180, screenBounds.x, "center")
  
  love.graphics.setFont(mediumFont)
  love.graphics.printf("Press Any Key to Play Again", 0, 750, screenBounds.x, "center")
  
  love.graphics.setColor(white)
end

function love.mousepressed(x, y)
  if gameState == "playing" then
    if board.state == "p1staging" and love.mouse.getX() >= 700 and love.mouse.getX() <= 800 and love.mouse.getY() >= 615 and love.mouse.getY() <= 655 then
      buttonSFX:play()
      board:submitTurn()
    end
  end
end

function love.keypressed(key)
  if gameState == "title" then
    buttonSFX:play()
    gameState = "playing"
  elseif gameState == "gameOver" then
    buttonSFX:play()
    initializeGame()
    gameState = "playing"
  end
end