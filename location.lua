
LocationClass = {}

function LocationClass:new(name, x, y)
  local location = {}
  local metadata = {__index = LocationClass}
  setmetatable(location, metadata)
  
  location.name = name
  location.x = x
  location.y = y
  location.p1cards = {}
  location.p2cards = {}
  
  require "vector"
  location.p1positions = {
    Vector(x, y),
    Vector(x + 100, y),
    Vector(x + 200, y),
    Vector(x + 300, y)
  }
  location.p2positions = {
    Vector(x, y - 140),
    Vector(x + 100, y - 140),
    Vector(x + 200, y - 140),
    Vector(x + 300, y - 140)
  }
  
  return location
end

function LocationClass:addCard(card)
  if card.owner == "p1" then
    table.insert(self.p1cards, card)
    card.position = self.p1positions[#self.p1cards]
  elseif card.owner == "p2" then
    table.insert(self.p2cards, card)
    card.position = self.p2positions[#self.p2cards]
  end
end

function LocationClass:draw()
  love.graphics.setColor(blue)
  love.graphics.rectangle("line", self.p1positions[1].x - 2, self.p1positions[1].y - 2, 399, 134)
  love.graphics.setColor(pink)
  love.graphics.rectangle("line", self.p2positions[1].x - 2, self.p2positions[1].y - 2, 399, 134)
  
  love.graphics.setColor(white)
  love.graphics.setFont(smallFont)
  
  love.graphics.printf(self.name, self.p2positions[1].x, self.p2positions[1].y - 23, 399, "center")
  love.graphics.printf(self.name, self.p1positions[1].x, self.p1positions[1].y + 133, 399, "center")
  
  love.graphics.setFont(largeFont)
end

  