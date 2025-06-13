-- The code in this file is based off of Zac Emerzian's in class demo on how to implement pop-up notifications.
NoticeClass = {}

function NoticeClass:new(text, index)
  local notice = {}
  setmetatable(notice, { __index = NoticeClass })

  notice.text = text or ""
  notice.index = index
  notice.timer = 2.5
  notice.visible = false
  notice.size = Vector(400, 40)

  return notice
end

function NoticeClass:show(text, index)
  self.text = text
  self.index = index
  self.timer = 4.0
  self.visible = true
end

function NoticeClass:update(dt)
  if self.visible then
    self.timer = self.timer - dt
    if self.timer <= 0 then
      self.visible = false
    end
  end
end

function NoticeClass:draw()
  if not self.visible then return end

  local pos = Vector(1000, 400 + (self.index - 1) * (self.size.y + 10))

  love.graphics.setColor(green)
  love.graphics.rectangle("fill", pos.x, pos.y, self.size.x, self.size.y, 10, 10)
  love.graphics.setColor(white)
  love.graphics.setFont(tinyFont)
  love.graphics.printf(self.text, pos.x + 10, pos.y + 8, self.size.x - 20, "center")
  love.graphics.setFont(largeFont)
end
