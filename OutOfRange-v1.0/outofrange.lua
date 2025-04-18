local UPDATE_INTERVAL = 0.1 -- interval for range checks
local elapsed = 0

local function UpdateButtonRange(self)
    local action = self.action
    local icon = self.icon
    if action and IsActionInRange(action) == false then
        icon:SetVertexColor(1.0, 0.1, 0.1)
    else
        icon:SetVertexColor(1.0, 1.0, 1.0)
    end
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed >= UPDATE_INTERVAL then
        elapsed = 0
        for _, button in pairs(ActionBarButtonEventsFrame.frames) do
            UpdateButtonRange(button)
        end
    end
end)

hooksecurefunc("ActionButton_UpdateUsable", UpdateButtonRange)
