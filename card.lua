
CardClass = {}

function CardClass:new(name, cost, power, xPos, yPos, owner)
  local card = {}
  local metadata = {__index = self}
  setmetatable(card, metadata)
  
  card.name = name
  card.cost = cost
  card.power = power
  require "vector"
  card.position = Vector(xPos, yPos)
  card.owner = owner
  card.location = nil
  
  card.backImage = love.graphics.newImage("Sprites/cardBack.png")
  card.frontImage = love.graphics.newImage("Sprites/" .. name .. ".png")
  card.image = card.backImage
  card.faceUp = false
  
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

function CardClass:checkWithinBounds(object)
  return object.x > self.position.x and
    object.x < self.position.x + self.size.x and
    object.y > self.position.y and
    object.y < self.position.y + self.size.y
end

function CardClass:flip()
  self.faceUp = not self.faceUp
  self.image = self.faceUp and self.frontImage or self.backImage
end

function CardClass:reveal()
  self:flip()
  noticeManager:add("No effect")
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
  if self.owner == "p1" then
    for _, card in ipairs(p2.hand.cards) do
      card.power = card.power - 1
    end
  else
    for _, card in ipairs(p1.hand.cards) do
      card.power = card.power - 1
    end
  end
  noticeManager:add("Zeus lowers the power of each card in the opponent's hand by 1!")
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
  if self.owner == "p1" then
    self.power = self.power + (2 * #self.location.p2cards)
  else
    self.power = self.power + (2 * #self.location.p1cards)
  end
  noticeManager:add("Ares gains +2 power for each enemy card at this location!")
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
  if self.owner == "p1" and #self.location.p2cards > 0 then
    local card = self.location:removeHighestCard("p2")
    for _, location in ipairs(locations) do
      if location ~= self.location and #location.p2cards < 4 then
        location:addCard(card)
        break
      end
    end
  elseif self.owner == "p2" and #self.location.p1cards > 0 then
    local card = self.location:removeHighestCard("p1")
    for _, location in ipairs(locations) do
      if location ~= self.location and #location.p1cards < 4 then
        location:addCard(card)
        break
      end
    end
  end
  noticeManager:add("Poseidon moves away an enemy card here with the lowest power!")
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
  if self.owner == "p1" then
    if #self.location.p2cards == 1 then
      self.power = self.power + 5
    end
  else
    if #self.location.p1cards == 1 then
      self.power = self.power + 5
    end
  end
  noticeManager:add("Artemis gains +5 power if there is one opposing card here!")
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
  if self.owner == "p1" then
    for _, card in ipairs(p1.hand.cards) do
      card.power = card.power + 1
    end
  else
    for _, card in ipairs(p2.hand.cards) do
      card.power = card.power + 1
    end
  end
  noticeManager:add("Hera gives cards in " .. self.owner .. "'s hand +1 power!")
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
  if self.owner == "p1" then
    self.power = self.power + (2 * #p1.discardPile.cards)
  else
    self.power = self.power + (2 * #p2.discardPile.cards)
  end
  noticeManager:add("Hades gains +2 power for each card in " .. self.owner .. "'s discard pile!")
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
  local strongest = true
  for _, card in ipairs(self.location.p1cards) do
    if card.power >= self.power then
      local strongest = false
      break
    end
  end
  for _, card in ipairs(self.location.p2cards) do
    if card.power >= self.power then
      local strongest = false
      break
    end
  end
  if strongest then
    self.power = self.power * 2
  end
  noticeManager:add("Hercules doubles its power if it is the strongest card here!")
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
  if self.owner == "p1" then
    self.power = self.power + (2 * (#self.location.p1cards - 1))
  else
    self.power = self.power + (2 * (#self.location.p2cards - 1))
  end
  noticeManager:add("Dionysus gains +2 power for each of " .. self.owner .. "'s other cards here!")
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
  local card = nil
  if self.owner == "p1" then
    for i = 1, #self.location.p1cards do
      card = self.location.p1cards[i]
      if card == self then
        table.remove(self.location.p1cards, i)
        break
      end
    end
    for i = 1, 3 do
      if locations[i] ~= self.location then
        if #locations[i].p1cards < 4 then 
          locations[i]:addCard(card)
          break
        end
      end
      if i == 3 then
        noticeManager:add("Hermes tried to move locations but other locations were full! Hermes goes away...")
        print("Hermes tried to move locations but other locations were full! Hermes goes away...")
      end
    end
  else
    for i = 1, #self.location.p2cards do
      card = self.location.p2cards[i]
      if card == self then
        table.remove(self.location.p2cards, i)
        break
      end
    end
    for i = 1, 3 do
      if locations[i] ~= self.location then
        if #locations[i].p2cards < 4 then 
          locations[i]:addCard(card)
          break
        end
      end
      if i == 3 then
        noticeManager:add("Hermes tried to move locations but other locations were full! Hermes goes away...")
        print("Hermes tried to move locations but other locations were full! Hermes goes away...")
      end
    end
  end
  noticeManager:add("Hermes moves to another location!")
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
  for _, card in ipairs(self.location.p1cards) do
    card.power = 3
  end
  for _, card in ipairs(self.location.p2cards) do
    card.power = 3
  end
  noticeManager:add("Midas sets all cards here to 3 power!")
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
  if self.owner == "p1" then
    for _, card in ipairs(self.location.p2cards) do
      card.power = card.power - 1
    end
  else
    for _, card in ipairs(self.location.p1cards) do
      card.power = card.power - 1
    end
  end
  noticeManager:add("Aphrodite lowers the power of each enemy card here by 1!")
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
  if self.owner == "p1" and #self.location.p1cards == 1 then
    self.power = self.power - 5
  elseif self.owner == "p2" and #self.location.p2cards == 1 then
    self.power = self.power - 5
  end
  noticeManager:add("Pandora's power gets lowered by 5 if no allies are here!")
  print("Pandora's power gets lowered by 5 if no allies are here!")
end













