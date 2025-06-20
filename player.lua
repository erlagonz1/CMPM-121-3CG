
PlayerClass = {}

function PlayerClass:new(name)
  local player = {}
  local metadata = {__index = PlayerClass}
  setmetatable(player, metadata)
  
  player.name = name
  player.mana = 1
  player.points = 0
  player.cards = {
    WoodenCowClass:new(name),
    PegasusClass:new(name),
    MinotaurClass:new(name),
    TitanClass:new(name),
    ZeusClass:new(name),
    AresClass:new(name),
    PoseidonClass:new(name),
    ArtemisClass:new(name),
    HeraClass:new(name),
    HadesClass:new(name),
    HerculesClass:new(name),
    DionysusClass:new(name),
    HermesClass:new(name),
    MidasClass:new(name),
    AphroditeClass:new(name),
    PandoraClass:new(name),
    WoodenCowClass:new(name),
    PegasusClass:new(name),
    MinotaurClass:new(name),
    TitanClass:new(name)
  }
  
  require "hand"
  require "deck"
  require "discardPile"
  
  if name == "p1" then
    local handX = 350
    local handY = 700
    player.hand = HandClass:new(handX, handY, name)
    local deckX = 200
    local deckY = 700
    player.deck = DeckClass:new(deckX, deckY, name)
    local discardPileX = 1100
    local discardPileY = 700
    player.discardPile = DiscardPileClass:new(discardPileX, discardPileY, name)
    
  elseif name == "p2" then
    local handX = 350
    local handY = 30
    player.hand = HandClass:new(handX, handY, name)
    local deckX = 200
    local deckY = 30
    player.deck = DeckClass:new(deckX, deckY, name)
    local discardPileX = 1100
    local discardPileY = 30
    player.discardPile = DiscardPileClass:new(discardPileX, discardPileY, name)
  end
  
  return player
end

function PlayerClass:shuffle()
  --shuffling function
  local cardCount = #self.cards
  for i = 1, cardCount do
    local randIndex = math.random(cardCount)
    local temp = self.cards[randIndex]
    self.cards[randIndex] = self.cards[cardCount]
    self.cards[cardCount] = temp
    cardCount = cardCount - 1
  end
end

function PlayerClass:drawFromDeck(amount)
  for i = 1, amount or 1 do
    if #self.hand.cards < 7 then
      local card = self.deck:removeCard()
      self.hand:addCard(card)
      if self.name == "p1" then
        card:flip()
      end
    end
  end
end

function PlayerClass:discard()
  self.discardPile:addCard(self.cards[1])
end

function PlayerClass:draw()
  
end


  
