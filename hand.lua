
HandClass = {}

function HandClass:new(x, y, owner)
  local hand = {}
  local metadata = {__index = HandClass}
  setmetatable(hand, metadata)
  
  require "vector"
  hand.positions = {
    Vector(x, y),
    Vector(x + 100, y),
    Vector(x + 200, y),
    Vector(x + 300, y),
    Vector(x + 400, y),
    Vector(x + 500, y),
    Vector(x + 600, y)
  }
  
  hand.cards = {}
  hand.owner = owner
  
  return hand
end

function HandClass:addCard(card, position)
  if position then
    table.insert(self.cards, position, card)
    card.position = self.positions[position]
  else
    table.insert(self.cards, card)
    card.position = self.positions[#self.cards]
  end
  print("card added to hand")
  
--  if #self.cards == 1 then
--    card.position = 
end

function HandClass:removeCard(index)
  print("card removed from hand")
  return table.remove(self.cards, index)
end

function HandClass:reorganize() --shifts all cards left if there are gaps from placing a card
  for i = 1, #self.cards do
    self.cards[i].position = self.positions[i]
  end
end

function HandClass:draw()
  if self.owner == "p1" then
    love.graphics.setColor(blue)
  elseif self.owner == "p2" then
    love.graphics.setColor(pink)
  end
  love.graphics.rectangle("line", self.positions[1].x - 2, self.positions[1].y - 2, 699, 134)
  love.graphics.setColor(white)
  love.graphics.setFont(smallFont)
  if self.owner == "p1" then
    love.graphics.printf("Hand", self.positions[1].x, self.positions[1].y - 23, 699, "center")
  elseif self.owner == "p2" then
    love.graphics.printf("Hand", self.positions[1].x, self.positions[1].y + 133, 699, "center")
  end
  love.graphics.setFont(largeFont)
end

    
    
    