
BoardClass = {}

function BoardClass:new()
  local board = {}
  metadata = {__index = BoardClass}
  setmetatable(board, metadata)
  
  board.turn = 0
  
  board.p1stages = {
    nil,
    nil,
    nil
  }
  
  board.p2stages = {
    nil,
    nil,
    nil
  }
  
  return board
end

function BoardClass:playTurn()
  
end


function BoardClass:checkWinner()
  
end


function BoardClass:draw()
  -- draw p1 attributes
  love.graphics.setColor(blue)
  love.graphics.line(0, screenBounds.y/2 + 1, screenBounds.x, screenBounds.y/2 + 1)
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(p1.mana), 15, screenBounds.y - 115, 150, "center")
  love.graphics.printf(tostring(p1.points), screenBounds.x - 170, screenBounds.y - 115, 150, "center")
  love.graphics.setColor(white)
  love.graphics.setFont(largeFont)
  love.graphics.printf("Mana", 15, screenBounds.y - 130, 150, "center")
  love.graphics.printf("Points", screenBounds.x - 170, screenBounds.y - 130, 150, "center")
  love.graphics.printf("Player 1", 15, screenBounds.y - 240, 150, "center")
    
  -- draw p2 attributes
  love.graphics.setColor(pink)
  love.graphics.line(0, screenBounds.y/2 - 1, screenBounds.x, screenBounds.y/2 - 1)
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(p2.mana), 15, 5, 150, "center")
  love.graphics.printf(tostring(p2.points), screenBounds.x - 170, 5, 150, "center")
  love.graphics.setColor(white)
  love.graphics.setFont(largeFont)
  love.graphics.printf("Mana", 15, 105, 150, "center")
  love.graphics.printf("Points", screenBounds.x - 170, 105, 150, "center") 
  love.graphics.printf("Player 2", 15, 210, 150, "center")

  -- draw the rest of the board features
  love.graphics.setColor(green)
  love.graphics.rectangle("fill", 700, 615, 100, 50)
  love.graphics.setColor(white)
  love.graphics.setFont(largeFont)
  love.graphics.printf("Submit", 706, 625, 150, "left")
  love.graphics.printf("Turn " .. tostring(self.turn), 600, 625, 150, "left")
end
