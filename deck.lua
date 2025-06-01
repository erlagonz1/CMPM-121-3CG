
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

