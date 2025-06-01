DiscardPileClass = {}

function DiscardPileClass:new(x, y, owner)
  local discardPile = {}
  local metadata = {__index = DiscardPileClass}
  setmetatable(discardPile, metadata)
  
  discardPile.x = x
  discardPile.y = y
  discardPile.owner = owner
  
  return discardPile
end
