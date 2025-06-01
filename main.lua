-- main.lua
-- author: Eric Gonzalez
-- 05/31/24

io.stdout:setvbuf("no")

math.randomseed(os.time())

-- require calls to different files
require "card"
require "player"

function love.load()
  
  -- color definitions
  white = {1, 1, 1, 1}
  red = {0.8, 0, 0, 1}
  green = {0, 0.7, 0.2, 1}
  blue = {0.5, 0.8, 1, 1}
  tan = {0.61, 0.52, 0.41, 1}
  
  largeFont = love.graphics.newFont(24)
  
  screenBounds = Vector(1440, 860)
  
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
end


function love.draw()
  for _, card in ipairs(p1.cards) do
    card:draw()
  end
  
  for _, card in ipairs(p2.cards) do
    card:draw()
  end
  
end
  

