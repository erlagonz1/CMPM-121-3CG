-- main.lua
-- author: Eric Gonzalez
-- 05/31/24

io.stdout:setvbuf("no")

math.randomseed(os.time())

-- require calls to different files
require "card"
require "player"
require "location"
require "grabber"
require "board"

function love.load()
  
  -- color definitions
  white = {1, 1, 1, 1}
  black = {0, 0, 0, 1}
  red = {0.8, 0, 0, 1}
  green = {0, 0.7, 0.2, 1}
  blue = {0.35, 0.55, 7, 1}
  pink = {0.5, 0.0, 0.5, 1}
  tan = {0.61, 0.52, 0.41, 1}
  
  smallFont = love.graphics.newFont(16)
  largeFont = love.graphics.newFont(24)
  hugeFont = love.graphics.newFont(100)
  
  love.graphics.setLineWidth(3)
  
  screenBounds = Vector(1400, 860)
  
  love.window.setMode(screenBounds.x, screenBounds.y)
  love.graphics.setBackgroundColor(tan)
  love.window.setTitle("Mythological Showdown v0.5")
  
  -- make p1 and p2 objects
  p1 = PlayerClass:new("p1")
  p2 = PlayerClass:new("p2") -- this is AI
  
  --shuffle cards
  --p1:shuffle()
  --p2:shuffle()
  
  -- add all cards to each player's deck
  for _, card in ipairs(p1.cards) do
    p1.deck:addCard(card)
  end
  
  for _, card in ipairs(p2.cards) do
    p2.deck:addCard(card)
  end
  
  -- remove three cards from each player's deck and add it to their hand
  p1:drawFromDeck(7)
  p2:drawFromDeck(7)
  
  -- initialize the locations
  
  locations = {}
  location1 = LocationClass:new("Location 1", 50, screenBounds.y/2 + 5)
  location2 = LocationClass:new("Location 2", 500, screenBounds.y/2 + 5)
  location3 = LocationClass:new("Location 3", 950, screenBounds.y/2 + 5)
  table.insert(locations, location1)
  table.insert(locations, location2)
  table.insert(locations, location3)
  
  grabber = GrabberClass:new()
  
  board = BoardClass:new()
  
end


function love.update()
  grabber:update()
end



function love.draw()
  
  p1.deck:draw()
  p2.deck:draw()
  
  p1.hand:draw()
  p2.hand:draw()
  
  p1.discardPile:draw()
  p2.discardPile:draw()
  
  location1:draw()
  location2:draw()
  location3:draw()
  
  board:draw()
  
  for _, card in ipairs(p1.cards) do
    card:draw()
  end
  
  for _, card in ipairs(p2.cards) do
    card:draw()
  end
  
end
  

