local COOLDOWN_SEC = 1.5
local cooldown = 0
local wasDown = false

ac.log('[recovery] script loaded')

function script.update(dt)
  if cooldown > 0 then cooldown = cooldown - dt end

  local down = ac.isKeyDown(ui.KeyIndex.Control) and ac.isKeyDown(ui.KeyIndex.K)
  local fired = down and not wasDown
  wasDown = down

  if fired and cooldown <= 0 then
    cooldown = COOLDOWN_SEC
    ac.log('[recovery] Ctrl+K fired, /resetcar sending')
    local ok, err = pcall(ac.sendChatMessage, '/resetcar')
    if not ok then ac.log('[recovery] error: ' .. tostring(err)) end
  end
end