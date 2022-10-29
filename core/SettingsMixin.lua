local _, PKG = ...

local Debug = PKG.Debug
local AFP = PKG.AddProfiling

local SettingsMixin = {}
AFP("SettingsMixin", SettingsMixin)
PKG.SettingsMixin = SettingsMixin

function SettingsMixin:SetTitle()
    self.Header.DefaultsButton:Hide()
    self.Header.Title:SetText("DeModal")
end

function SettingsMixin:AddToSettings()
    -- manually creating options until vertical frame taint bugs are sorted
    local category = Settings.RegisterCanvasLayoutCategory(self, "DeModal")
    Settings.RegisterAddOnCategory(category)
end

local function resetFrames_onClick(btn)
    Debug("reset saved frame data")
    table.wipe(DEMODAL_CHAR_DB["frames"])
    table.wipe(DEMODAL_DB["frames"])
    ReloadUI()
end
AFP("resetFrames_onClickk", resetFrames_onClick)

function SettingsMixin:AddOptions()
    -- manually creating options until Blizzards vertical frame taint bugs are sorted
    local f = self.ScrollBox.ScrollTarget

    local btn = CreateFrame("Frame", nil, f, "SettingsCheckBoxControlTemplate")
    f.PerCharOption = btn
    btn:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -10)
    btn.Text:SetText("Save windows only for this character")
    btn.CheckBox:ClearAllPoints()
    btn.CheckBox:SetPoint("TOPRIGHT")

    local btnReset = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    btnReset:SetText("Reset All Saved Window Settings")
    btnReset:SetWidth(300)
    btnReset:SetPoint("TOPLEFT", btn, "BOTTOMLEFT", 0, -10)
    btnReset:HookScript("OnClick", resetFrames_onClick)
end

local function perCharPos_onClick(btn)
    DEMODAL_CHAR_DB["per_char_positions"] = btn:GetChecked()
end
AFP("perCharPos_onClick", perCharPos_onClick)

function SettingsMixin:SetOptionValues()
    local f = self.ScrollBox.ScrollTarget

    f.PerCharOption.CheckBox:HookScript("OnClick", perCharPos_onClick)
    if DEMODAL_CHAR_DB["per_char_positions"] then
        f.PerCharOption.CheckBox:SetChecked(true)
    else
        f.PerCharOption.CheckBox:SetChecked(false)
    end
end

local SF = nil
SettingsMixin.Init = function()
    if SF then
        return SF
    end
    SF = CreateFrame("Frame", nil, nil, "SettingsListTemplate")
    Mixin(SF, SettingsMixin)
    SF:SetTitle()
    SF:AddOptions()
    SF:AddToSettings()
    return SF
end
