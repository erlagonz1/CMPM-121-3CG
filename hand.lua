
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

function HandClass:reorganize()
  
end
