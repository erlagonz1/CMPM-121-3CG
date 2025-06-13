
BoardClass = {}

function BoardClass:new()
  local board = {}
  metadata = {__index = BoardClass}
  setmetatable(board, metadata)
  
  board.turn = 1
  board.state = nil
  board.p1moved = false
  board.p2moved = false
  
  board.p1stages = {nil, nil, nil}
  self.p1stageNum = 1
  board.p2stages = {nil, nil, nil}
  
  board.first = nil
  board:determineOrder()
  
  return board
end


function BoardClass:determineOrder()
  if p1.points > p2.points then
    self.state = "p1staging"
  elseif p2.points > p1.points then
    self.state = "p2staging"
  else
    self.state = love.math.random(1, 2) == 1 and "p1staging" or "p2staging" -- choose a random player if both have the same number of points
  end
  if self.state == "p1staging" then
    self.first = "p1"
  else
    self.first = "p2"
  end
end


function BoardClass:update()
  if self.state == "p2staging" then
    self:p2stage()
    if self.p1moved == false then
      self.state = "p1staging"
    else
      self.state = "resolving"
    end
  elseif self.state == "resolving" then
    self:resolveTurn()
  end
end


function BoardClass:submitTurn()
  self.p1moved = true
  if self.p2moved == false then
    self.state = "p2staging"
  else
    self.state = "resolving"
  end
end


function BoardClass:p2stage() -- places at max three cards randomly from its hand
  local counter = 1
  for i = 1, 3 do
    if math.random() < 0.9 and #p2.hand.cards > 0 then 
      local locationIndex = math.random(1, 3)
      local location = locations[locationIndex]
      local handIndex = math.random(1, #p2.hand.cards)
      local card = p2.hand.cards[handIndex]
      --try to place down the random card at the random location
      if p2.mana >= card.cost and #location.p2cards < 4 then
        self.p2stages[counter] = card
        location:addCard(card)
        card.location = location
        p2.hand:removeCard(handIndex)
        p2.mana = p2.mana - card.cost
        counter = counter + 1
      end
    end
  end
  p2.hand:reorganize()
  self.p2moved = true
end


function BoardClass:resolveTurn()
  -- reveal cards in the order staged
  if self.first == "p1" then
    for _, card in ipairs(self.p1stages) do
      card:reveal()
    end
    for _, card in ipairs(self.p2stages) do
      card:reveal()
    end
  elseif self.first == "p2" then
    for _, card in ipairs(self.p2stages) do
      card:reveal()
    end
    for _, card in ipairs(self.p1stages) do
      card:reveal()
    end
  end

  -- Calculate points from each location
  for _, location in ipairs(locations) do
    local locationP1Total = 0
    local locationP2Total = 0
    for _, card in ipairs(location.p1cards) do
      locationP1Total = locationP1Total + card.power
    end
    for _, card in ipairs(location.p2cards) do
      locationP2Total = locationP2Total + card.power
    end
    if locationP1Total > locationP2Total then
      p1.points = p1.points + (locationP1Total -locationP2Total)
    elseif locationP2Total > locationP1Total then
      p2.points = p2.points + (locationP2Total -locationP1Total)
    end
  end

  -- Check for winner
  if self:checkWinner() then
    self.state = "gameOver"
  else
    self.turn = self.turn + 1
    self:resetVariables()
    self:determineOrder()
  end
end


function BoardClass:checkWinner()
  if p1.points >= 25 and p2.points >= 25 then
    if p1.points >= p2.points then
      print("Player 1 wins!")
      return true
    else
      print("Player 2 wins!")
      return true
    end
  elseif p1.points >= 25 then
    print("Player 1 wins!")
    return true
  elseif p2.points >= 25 then
    print("Player 2 wins!")
    return true
  end
end


function BoardClass:resetVariables()
  p1.mana = self.turn
  p2.mana = self.turn
  p1:drawFromDeck()
  p2:drawFromDeck()
  self.p1stages = {nil, nil, nil}
  self.p2stages = {nil, nil, nil}
  self.p1moved = false
  self.p2moved = false
  self.p1stageNum = 1
end


function BoardClass:draw()
  
  if self.state ~= "gameOver" then
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
    if p1.moved then
      love.graphics.setColor(red)
    else
      love.graphics.setColor(green)
    end
    love.graphics.rectangle("fill", 700, 615, 100, 50)
    love.graphics.setColor(white)
    love.graphics.setFont(largeFont)
    love.graphics.printf("Submit", 706, 625, 150, "left")
    love.graphics.printf("Turn " .. tostring(self.turn), 600, 625, 150, "left")
  end
  
  love.graphics.setColor(white)
  love.graphics.setFont(largeFont)
end