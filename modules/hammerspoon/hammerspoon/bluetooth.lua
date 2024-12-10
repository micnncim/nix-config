-- NOTE: Hammerspoon needs to be granted Bluetooth permissions in
-- System Settings > Security & Privacy > Bluetooth.

-- Switches Bluetooth devices when when an external display is connected or
-- disconnected.

local devices = {
  ["Magic Trackpad"] = "08-65-18-ba-8e-4b",
  ["Pebble V3"] = "00-02-3c-b4-26-b5",
}

local externalDisplay = "LG ULTRAWIDE"

hs.screen.watcher.new(function()
  if hs.screen.mainScreen():name() == externalDisplay then
    for device, id in pairs(devices) do
      local _, success = hs.execute("blueutil --connect " .. id, true)
      if success then
        hs.notify.new({title="Bluetooth", informativeText="Connected to " .. device}):send()
      end
    end
  else
    for device, id in pairs(devices) do
      hs.execute("blueutil --disconnect " .. id, true)
    end
  end
end):start()
