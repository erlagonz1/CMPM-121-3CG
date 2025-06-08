
DeckClass = {}

function DeckClass:new(x, y, owner)
  local deck = {}
  local metadata = {__index = DeckClass}
  setmetatable(deck, metadata)
  
  require "vector"
  deck.position = Vector(x, y)
  deck.owner = owner
  
  deck.cards = {}
  
  return deck
end

function DeckClass:addCard(card)
  table.insert(self.cards, card)
  card.position = self.position
  print("card inserted and moved")
end

function DeckClass:removeCard()
  print("card removed from deck")
  return table.remove(self.cards)
end

function DeckClass:draw()
  if self.owner == "p1" then
    love.graphics.setColor(blue)
  elseif self.owner == "p2" then
    love.graphics.setColor(pink)
  end
  love.graphics.rectangle("line", self.position.x - 2, self.position.y - 2, 99, 134)
  love.graphics.setColor(white)
  love.graphics.setFont(smallFont)
  if self.owner == "p1" then
    love.graphics.printf("Draw Pile", self.position.x - 28, self.position.y - 23, 150, "center")
  elseif self.owner == "p2" then
    love.graphics.printf("Draw Pile", self.position.x - 28, self.position.y + 133, 150, "center")
  end
  love.graphics.setFont(largeFont)
end


