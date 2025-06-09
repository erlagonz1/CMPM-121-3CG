
GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.currentMousePos = nil
  grabber.grabPos = nil
  grabber.heldObject = nil
  grabber.grabOffset = nil
  grabber.cardIndex = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  
  if self.heldObject then
    self.heldObject.position = self.currentMousePos - self.grabOffset
  end
  
  if love.mouse.isDown(1) and not self.heldObject then
    self:grab()
  end
  
  if not love.mouse.isDown(1) and self.heldObject then
    self:release()
  end
  
  
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
  
  for i = 1, #p1.hand.cards do
    if p1.hand.cards[i]:checkWithinBounds(self.grabPos) and board.state == "p1staging" then
      self.heldObject = p1.hand.cards[i]
      self.grabOffset = self.currentMousePos - p1.hand.cards[i].position
      self.cardIndex = i
      p1.hand:removeCard(i)
      
      break
    end
  end
  
end

function GrabberClass:release()
  if self.heldObject == nil then
    return
  end
  
  local moved = false
  
  -- if placement is valid, put the card in the location
  for _, location in ipairs(locations) do
    if self.heldObject.position.x + halfCardWidth >= location.x and self.heldObject.position.x + halfCardWidth <= location.x + 400 and self.heldObject.position.y + halfCardHeight >= location.y and self.heldObject.position.y + halfCardHeight <= location.y + 134 then
      if self:isValidPlacement(location) then
        location:addCard(self.heldObject)
        self.heldObject.location = location
        board.p1stages[board.p1stageNum] = self.heldObject
        p1.mana = p1.mana - self.heldObject.cost
        p1.hand:reorganize()
        board.p1stageNum = board.p1stageNum + 1
        self.heldObject:flip()
        moved = true
        break
      end
    end
  end
  
  
--if placement is not valid, put add the card back to p1hand
  if not moved then
    p1.hand:addCard(self.heldObject, self.cardIndex)
  end
  
  self.heldObject = nil
  self.cardIndex = nil
  self.grabPos = nil
  self.grabOffset = nil

  
end

function GrabberClass:isValidPlacement(location)
  if p1.mana < self.heldObject.cost or #location.p1cards >= 4 then
    return false
  else
    return true
  end
end
