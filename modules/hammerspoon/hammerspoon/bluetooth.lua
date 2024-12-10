-- NOTE: Hammerspoon needs to be granted Bluetooth permissions in
-- System Settings > Security & Privacy > Bluetooth.

-- Switches Bluetooth devices when the number of screens changes; i.e. when
-- an external display is connected or disconnected.

local devices = {
  ["Magic Trackpad"] = "08-65-18-ba-8e-4b",
  ["Pebble V3"] = "00-02-3c-b4-26-b5",
}

hs.screen.watcher.new(function()
  local screens = hs.screen.allScreens()
  if #screens == 1 then
    for device, bluetooth_id in pairs(devices) do
      hs.execute("blueutil --disconnect " .. bluetooth_id, true)
    end
  else
    for device, bluetooth_id in pairs(devices) do
      local _, success = hs.execute("blueutil --connect " .. bluetooth_id, true)
      if success then
        hs.notify.new({title="Bluetooth", informativeText="Connected to " .. device}):send()
      end
    end
  end
end):start()
