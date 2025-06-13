-- The code in this file is based off of Zac Emerzian's in class demo on how to implement pop-up notifications.
require "notice"

NoticeManager = {}

function NoticeManager:new()
  local manager = {}
  setmetatable(manager, { __index = NoticeManager })

  manager.notices = {
    NoticeClass:new("", 1),
    NoticeClass:new("", 2),
    NoticeClass:new("", 3)
  }

  return manager
end

function NoticeManager:add(text)
  for _, notice in ipairs(self.notices) do
    if not notice.visible then
      notice:show(text, notice.index)
      return
    end
  end
end

function NoticeManager:update(dt)
  for _, notice in ipairs(self.notices) do
    notice:update(dt)
  end
end

function NoticeManager:draw()
  for _, notice in ipairs(self.notices) do
    notice:draw()
  end
end
