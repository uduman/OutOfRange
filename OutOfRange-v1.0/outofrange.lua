local UPDATE_INTERVAL = 0.1 -- interval for range checks
local elapsed = 0

local function UpdateButtonRange(self)
    local action = self.action
    local icon = self.icon
    if action then
        local isUsable, notEnoughMana = IsUsableAction(action)
        local inRange = IsActionInRange(action)
        if not isUsable then
            -- Action is unusable (talent not picked, no mana, etc.)
            icon:SetVertexColor(0.4, 0.4, 0.4) -- grey (unusable)
        elseif inRange == false then
            -- Action is usable but out of range
            icon:SetVertexColor(1.0, 0.1, 0.1) -- red (out of range)
        else
            -- Action is usable and in range
            icon:SetVertexColor(1.0, 1.0, 1.0) -- normal color
        end
    end

end

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed >= UPDATE_INTERVAL then
        elapsed = 0
        for _, button in pairs(ActionBarButtonEventsFrame.frames) do
            UpdateButtonRange(button)
        end
    end
end)

hooksecurefunc("ActionButton_UpdateUsable", UpdateButtonRange)