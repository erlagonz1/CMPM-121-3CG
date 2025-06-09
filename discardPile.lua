
DiscardPileClass = {}

function DiscardPileClass:new(x, y, owner)
  local discardPile = {}
  local metadata = {__index = DiscardPileClass}
  setmetatable(discardPile, metadata)
  
  require "vector"
  discardPile.position = Vector(x,y)
  discardPile.owner = owner
  
  discardPile.cards = {}
  
  return discardPile
end

function DiscardPileClass:addCard(card)
  table.insert(self.cards, card)
  card.position = self.position
end

function DiscardPileClass:draw()
  if self.owner == "p1" then
    love.graphics.setColor(blue)
  elseif self.owner == "p2" then
    love.graphics.setColor(pink)
  end
  love.graphics.rectangle("line", self.position.x - 2, self.position.y - 2, 99, 134)
  love.graphics.setColor(white)
  love.graphics.setFont(smallFont)
  if self.owner == "p1" then
    love.graphics.printf("Discard Pile", self.position.x - 28, self.position.y - 23, 150, "center")
  elseif self.owner == "p2" then
    love.graphics.printf("Discard Pile", self.position.x - 28, self.position.y + 133, 150, "center")
  end
  love.graphics.setFont(largeFont)
end
