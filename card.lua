
require "vector"

CardClass = {}

--CARD_STATE = {
--  IDLE = 0,
--  MOUSE_OVER = 1,
--  GRABBED = 2,
--}

function CardClass:new(name, cost, power, xPos, yPos, owner)
  local card = {}
  local metadata = {__index = self}
  setmetatable(card, metadata)
  
  card.name = name
  card.cost = cost
  card.power = power
  card.position = Vector(xPos, yPos)
  --card.state = CARD_STATE.IDLE
  card.owner = owner
  
  card.backImage = love.graphics.newImage("Sprites/CardBack.png")
  card.frontImage = love.graphics.newImage("Sprites/" .. name .. ".png")
  card.image = card.backImage
  card.faceUp = true
  
  card.size = Vector(card.image:getWidth(), card.image:getHeight())
  
  return card
end

function CardClass:draw()
  
  if self.faceUp then
    self.image = self.frontImage
    love.graphics.draw(self.image, self.position.x, self.position.y)
    love.graphics.setColor(red)
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(self.power), self.position.x + 12, self.position.y + 6.2)
    love.graphics.setColor(white)
  else
    -- Draw the card back
    self.image = self.backImage
    love.graphics.draw(self.image, self.position.x, self.position.y)
  end
end

function CardClass:flip()
  self.faceUp = not self.faceUp
  self.image = self.faceUp and self.frontImage or self.backImage
end

function CardClass:reveal()
  self:flip()
  print("No effect")
end


-- specific card definitions
WoodenCowClass = {}
setmetatable(WoodenCowClass, {__index = CardClass})

function WoodenCowClass:new(owner, x, y)
  local card = CardClass.new(self, "woodenCow", 1, 1, x or 0, y or 0, owner)
  setmetatable(card, {__index = WoodenCowClass})
  return card
end


PegasusClass = {}
setmetatable(PegasusClass, {__index = CardClass})

function PegasusClass:new(owner, x, y)
  local card = CardClass.new(self, "pegasus", 3, 5, x or 0, y or 0, owner)
  setmetatable(card, {__index = PegasusClass})
  return card
end


MinotaurClass = {}
setmetatable(MinotaurClass, {__index = CardClass})

function MinotaurClass:new(owner, x, y)
  local card = CardClass.new(self, "minotaur", 5, 9, x or 0, y or 0, owner)
  setmetatable(card, {__index = MinotaurClass})
  return card
end


TitanClass = {}
setmetatable(TitanClass, {__index = CardClass})

function TitanClass:new(owner, x, y)
  local card = CardClass.new(self, "titan", 6, 12, x or 0, y or 0, owner)
  setmetatable(card, {__index = TitanClass})
  return card
end


ZeusClass = {}
setmetatable(ZeusClass, {__index = CardClass})

function ZeusClass:new(owner, x, y)
  local card = CardClass.new(self, "zeus", 8, 15, x or 0, y or 0, owner)
  setmetatable(card, {__index = ZeusClass})
  return card
end

function ZeusClass:reveal()
  self:flip()
  print("Zeus lowers the power of each card in the opponent's hand by 1!")
end


AresClass = {}
setmetatable(AresClass, {__index = CardClass})

function AresClass:new(owner, x, y)
  local card = CardClass.new(self, "ares", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = AresClass})
  return card
end

function AresClass:reveal()
  self:flip()
  print("Ares gains +2 power for each enemy card at this location!")
end


PoseidonClass = {}
setmetatable(PoseidonClass, {__index = CardClass})

function PoseidonClass:new(owner, x, y)
  local card = CardClass.new(self, "poseidon", 7, 13, x or 0, y or 0, owner)
  setmetatable(card, {__index = PoseidonClass})
  return card
end

function PoseidonClass:reveal()
  self:flip()
  print("Poseidon moves away an enemy card here with the lowest power!")
end


ArtemisClass = {}
setmetatable(ArtemisClass, {__index = CardClass})

function ArtemisClass:new(owner, x, y)
  local card = CardClass.new(self, "artemis", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = ArtemisClass})
  return card
end

function ArtemisClass:reveal()
  self:flip()
  print("Artemis gains +5 power if there is one opposing card here!")
end


HeraClass = {}
setmetatable(HeraClass, {__index = CardClass})

function HeraClass:new(owner, x, y)
  local card = CardClass.new(self, "hera", 8, 15, x or 0, y or 0, owner)
  setmetatable(card, {__index = HeraClass})
  return card
end

function HeraClass:reveal()
  self:flip()
  print("Hera gives cards in " .. self.owner .. "'s hand +1 power!")
end


HadesClass = {}
setmetatable(HadesClass, {__index = CardClass})

function HadesClass:new(owner, x, y)
  local card = CardClass.new(self, "hades", 7, 13, x or 0, y or 0, owner)
  setmetatable(card, {__index = HadesClass})
  return card
end

function HadesClass:reveal()
  self:flip()
  print("Hades gains +2 power for each card in " .. self.owner .. "'s discard pile!")
end


HerculesClass = {}
setmetatable(HerculesClass, {__index = CardClass})

function HerculesClass:new(owner, x, y)
  local card = CardClass.new(self, "hercules", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = HerculesClass})
  return card
end

function HerculesClass:reveal()
  self:flip()
  print("Hercules doubles its power if it is the strongest card here!")
end


DionysusClass = {}
setmetatable(DionysusClass, {__index = CardClass})

function DionysusClass:new(owner, x, y)
  local card = CardClass.new(self, "dionysus", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = DionysusClass})
  return card
end

function DionysusClass:reveal()
  self:flip()
  print("Dionysus gains +2 power for each of " .. self.owner .. "'s other cards here!")
end


HermesClass = {}
setmetatable(HermesClass, {__index = CardClass})

function HermesClass:new(owner, x, y)
  local card = CardClass.new(self, "hermes", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = HermesClass})
  return card
end

function HermesClass:reveal()
  self:flip()
  print("Hermes moves to another location!")
end


MidasClass = {}
setmetatable(MidasClass, {__index = CardClass})

function MidasClass:new(owner, x, y)
  local card = CardClass.new(self, "midas", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = MidasClass})
  return card
end

function MidasClass:reveal()
  self:flip()
  print("Midas sets all cards here to 3 power!")
end


AphroditeClass = {}
setmetatable(AphroditeClass, {__index = CardClass})

function AphroditeClass:new(owner, x, y)
  local card = CardClass.new(self, "aphrodite", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = AphroditeClass})
  return card
end

function AphroditeClass:reveal()
  self:flip()
  print("Aphrodite lowers the power of each enemy card here by 1!")
end


PandoraClass = {}
setmetatable(PandoraClass, {__index = CardClass})

function PandoraClass:new(owner, x, y)
  local card = CardClass.new(self, "pandora", 6, 10, x or 0, y or 0, owner)
  setmetatable(card, {__index = PandoraClass})
  return card
end

function PandoraClass:reveal()
  self:flip()
  print("Pandora's power gets lowered by 5 if no allies are here!")
end













