local _, PKG = ...

local Debug = PKG.Debug
local AFP = PKG.AddProfiling

local SettingsMixin = {}
AFP("SettingsMixin", SettingsMixin)
PKG.SettingsMixin = SettingsMixin

function SettingsMixin:SetTitle()
    local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("DeModal")
    self.title = title
end

function SettingsMixin:AddToSettings()
    self.name = "DeModal"
    InterfaceOptions_AddCategory(self)
end

local function resetFrames_onClick(btn)
    Debug("reset saved frame data")
    table.wipe(DEMODAL_CHAR_DB["frames"])
    table.wipe(DEMODAL_DB["frames"])
    ReloadUI()
end
AFP("resetFrames_onClickk", resetFrames_onClick)

function SettingsMixin:AddOptions()
    local btn = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
    self.PerCharOption = btn
    btn:SetPoint("TOPLEFT", self.title, "BOTTOMLEFT", -2, -16)
    btn.label = btn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    btn.label:SetPoint("TOPLEFT", 30, -6)
    btn.label:SetText("Save windows only for this character")

    local btnReset = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")
    btnReset:SetText("Reset All Saved Window Settings")
    btnReset:SetWidth(300)
    btnReset:SetPoint("TOPLEFT", btn, "BOTTOMLEFT", 0, -10)
    btnReset:HookScript("OnClick", resetFrames_onClick)
end

function SettingsMixin:SetOptionValues()
    -- no-op, handled in OnShow
end

function SettingsMixin:okay()
    Debug("update setting PerCharOption:", self.PerCharOption:GetChecked())
    DEMODAL_CHAR_DB["per_char_positions"] = self.PerCharOption:GetChecked()
end

function SettingsMixin:OnShow()
    if DEMODAL_CHAR_DB["per_char_positions"] then
        self.PerCharOption:SetChecked(true)
    else
        self.PerCharOption:SetChecked(false)
    end
end

local SF = nil
SettingsMixin.Init = function()
    if SF then
        return SF
    end
    SF = CreateFrame("Frame")
    SF:Hide()
    Mixin(SF, SettingsMixin)
    SF:HookScript("OnShow", SF.OnShow)
    SF:SetTitle()
    SF:AddOptions()
    SF:AddToSettings()
    return SF
end
