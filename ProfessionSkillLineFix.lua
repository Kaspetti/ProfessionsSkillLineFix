local selectedSkillLine = C_TradeSkillUI.GetProfessionChildSkillLineID()
local haveChanged = false

local frame = CreateFrame("Frame")

frame:RegisterEvent("TRADE_SKILL_SHOW")
frame:RegisterEvent("TRADE_SKILL_CLOSE")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "TRADE_SKILL_SHOW" then
        C_Timer.After(0.1, function()
            C_TradeSkillUI.SetProfessionChildSkillLineID(selectedSkillLine)
            haveChanged = true
        end)
    elseif event == "TRADE_SKILL_CLOSE" then
        haveChanged = false
    end
end)

-- Define a function to check for skill line changes
local function CheckSkillLine()
    -- Only check if the professions frame is visible
    -- Also make sure we have changed the skill line after open to avoid chaning to the wrong skill line (the bug we are trying to fix)
    if not ProfessionsFrame:IsVisible() or not haveChanged then
        return
    end

    local newSkillLine = C_TradeSkillUI.GetProfessionChildSkillLineID()

    if newSkillLine ~= selectedSkillLine then
        selectedSkillLine = newSkillLine
    end
end

-- Call the CheckSkillLine function periodically
C_Timer.NewTicker(0.5, CheckSkillLine)
