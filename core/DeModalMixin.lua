local _, PKG = ...

local Debug = PKG.Debug
local AFP = PKG.AddProfiling

local DeModalMixin = {}
AFP("DeModalMixin", DeModalMixin)
PKG.DeModalMixin = DeModalMixin

function DeModalMixin:Init()
    -- flag tracking whether addon has finished initial loading
    self.loaded = false

    -- normal frames that we always try to mass-close
    self.uiClosableFrames = {}
    
    -- protected frames that we only try to mass-close out of combat
    self.uiProtectedFrames = {}

    -- protected frames that need deferred hook because they were initially loaded in combat
    self.fixProtectedFrames = {}
end

local function protectedRaise_OnShow(self)
    if not InCombatLockdown() then
         self:Raise()
    end
end
AFP("protectedRaise_OnShow", protectedRaise_OnShow)

local function protectedDebug(self, ...)
    Debug(...)
end
AFP("protectedDebug", protectedDebug)

local protectedEsc_OnShow = [=[
    local keyEsc = GetBindingKey("TOGGLEGAMEMENU")
    local clsBtn = self:GetAttribute("CloseButtonName")
    if clsBtn and keyEsc ~= nil then
        --self:CallMethod("Debug", "set close button", clsBtn)
        self:SetBindingClick(false, keyEsc, clsBtn, "ESC")
    end
]=]

local protectedEsc_OnHide = [=[
    self:ClearBindings()
]=]

local function hook_closeOnClick(self, button, down)
    if button == "ESC" then
        -- TODO: not 100% sure this is taint-safe; might need an incombat wrap
        CloseWindows()
    end
end
AFP("hook_closeOnClick", hook_closeOnClick)

-- fix various quirks unique to specific frames
function DeModalMixin:FixQuirks(fName, f)
    if fName == "WardrobeFrame" then
        -- prevent circular setpoint refs between transmog and collection frames
        -- this might cause issues/overlap with the page label in other languages
        -- but it should be minor and I can't think of an alternative way to do it
        local wtf = _G.WardrobeTransmogFrame
        if wtf then
            if PKG.gameVersion == "retail" then
                wtf.ToggleSecondaryAppearanceCheckbox.Label:ClearPoint("RIGHT")
            else
                wtf.ToggleSecondaryAppearanceCheckbox.Label:ClearPointByName("RIGHT")
            end
            wtf.ToggleSecondaryAppearanceCheckbox.Label:SetWidth(110)
        end
    elseif fName == "CollectionsJournal" then
        -- collection journal is on the "HIGH" strata by default
        f:SetFrameStrata("MEDIUM")
    elseif fName == "EncounterJournal" then
        -- prevent circular setpoint refs on EJ's tooltip; seems to get
        -- positioned properly anyway OnEnter/Show
        local ejt = _G.EncounterJournalTooltip
        if ejt then
            ejt:ClearAllPoints()
        end
    end
end

function DeModalMixin:HookMovable(f, fName, wasArea)
    local UIPW = _G.UIPanelWindows
    if f:IsProtected() and InCombatLockdown() then
        Debug("defer hook of movable frame:", fName)
        local setWasArea = false
        if UIPW[fName] and UIPW[fName]["area"] then
            -- disable default panel positioning for this frame
            UIPW[fName]["area"] = nil
            setWasArea = true
        end
        tinsert(self.fixProtectedFrames, {f, fName, setWasArea})
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    else
        Debug("hook movable frame:", fName)
    end

    self:FixQuirks(fName, f)

    f:SetMovable(true)
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:EnableMouse(true)
    f:HookScript("OnDragStart", f.StartMoving)
    f:HookScript("OnDragStop", f.StopMovingOrSizing)
    if f:IsProtected() then
        f:HookScript("OnShow", protectedRaise_OnShow)
    else
        f:HookScript("OnShow", f.Raise)
    end
    f:RegisterForDrag("LeftButton")
    if f:GetNumPoints() == 0 then
        Debug("frame with 0 points, setting anchor:", fName)
        f:SetPoint("CENTER", UIParent)
    end

    if wasArea or (UIPW[fName] and UIPW[fName]["area"]) then
        -- disable default panel positioning for this frame
        UIPW[fName]["area"] = nil
        if not f:IsProtected() then
            -- add to list of frames that get closed with ESC
            Debug("frame added to closable frames:", fName)
            -- add to this list so the generic window manager knows stuff was open
            -- (and therefore doesn't show the ESC menu)
            tinsert(UISpecialFrames, fName)
            -- add to this list so we can also "click" close buttons to cleanup in
            -- our CloseWindows hook, as some frames need extra processing to close
            -- properly (e.g. AnimaDiversionFrame) that is not otherwise run
            tinsert(self.uiClosableFrames, f)
        else
            -- special handling required for ESC on protected frames
            Debug("frame is protected, need special ESC handler:", fName)
            tinsert(self.uiProtectedFrames, fName)
            local lp = CreateFrame("Frame", nil, f, "SecureHandlerShowHideTemplate")
            lp:ClearAllPoints()
            lp:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
            lp:SetSize(2, 2)
            lp.Debug = protectedDebug
            local btnClose = PKG.frameCloseButtons[fName]
            if btnClose then
                local btnName = btnClose[PKG.gameVersion]
                if not btnName then
                    btnName = btnClose.name
                end
                if btnName and _G[btnName] then
                    lp:SetAttribute("CloseButtonName", btnName)
                    _G[btnName]:HookScript("OnClick", hook_closeOnClick)
                else
                    Debug("uh oh, close button did not exist:", btnName, fName)
                end
            else
                Debug("uh oh, missing close button name for protected frame:", fName)
            end
            lp:SetAttribute("_onshow", protectedEsc_OnShow)
            lp:SetAttribute("_onhide", protectedEsc_OnHide)
        end
    end
end

function DeModalMixin:HookMovableHeader(f, hf)
    if not f or not hf then
        return
    end
    Debug("hook movable header for frame:", hf:GetName())
    hf:EnableMouse(true)
    hf:HookScript("OnDragStart", function () f:StartMoving() end)
    hf:HookScript("OnDragStop", function () f:StopMovingOrSizing() end)
    hf:RegisterForDrag("LeftButton")
end

function DeModalMixin:CloseWindowsHook(ignoreCenter, frameToIgnore)
    for i, f in ipairs(self.uiClosableFrames) do
        local fName = f:GetName()
        local fBtn = f.CloseButton or _G[fName .. "CloseButton"]
        if fBtn and fBtn.Click then
            fBtn:Click()
        end
    end
    if InCombatLockdown() then
        return
    end
    for i, fName in ipairs(self.uiProtectedFrames) do
        local f = _G[ fName ]
        if f and (not frameToIgnore or frameToIgnore ~= f) then
            f:Hide()
        end
    end
end

function DeModalMixin:Load()
    -- hook CloseWindows for special handling of protected frames
    hooksecurefunc("CloseWindows", function() self:CloseWindowsHook() end)

    -- hook pre-loaded simple frames
    local gv = PKG.gameVersion
    for i = 1, #PKG.frameXML do
        if PKG.frameXML[i][gv] then
            local fName = PKG.frameXML[i].f
            local f = _G[ fName ]
            if f then
                self:HookMovable(f, fName)
            else
                Debug("missing frame that should not be missing:", fName)
            end
        end
    end

    -- hook addon-based frames that might already be loaded
    for addonName, addonInfo in pairs(PKG.addonFrames) do
        self:LoadAddon(addonInfo, true)
    end

    self.loaded = true

    Debug("DeModal loaded")
end

function DeModalMixin:LoadAddon(addonInfo, ignoreMissing)
    for _, fName in ipairs(addonInfo) do
        local f = _G[ fName ]
        if f then
            self:HookMovable(f, fName)
            if PKG.headerFrames[fName] then
                -- dumb way to handle special frames that need extra work
                if (f.Header) then
                    self:HookMovableHeader(f, f.Header)
                else
                    self:HookMovableHeader(f, _G[ PKG.headerFrames[fName] ])
                end
            end
        elseif not ignoreMissing then
            Debug("missing frame that should not be missing:", fName)
        end
    end
end

function DeModalMixin:AddonLoadedEvent(addOnName)
    if addOnName == "DeModal" then
        Debug("DeModal ADDON_LOADED event")
        if self.loaded then
            return
        end
        self:Load()
    elseif PKG.addonFrames[addOnName] then
        if not self.loaded then
            return
        end
        Debug("addon load event for:", addOnName)
        self:LoadAddon(PKG.addonFrames[addOnName])
        --PKG.addonFrames[addOnName] = nil
    end
end

function DeModalMixin:PlayerRegenEnabledEvent()
    if InCombatLockdown() then
        return
    end
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    if #self.fixProtectedFrames > 0 then
        for i, fixMe in ipairs(self.fixProtectedFrames) do
            local f = fixMe[1]
            f:Hide()
            self:HookMovable(f, fixMe[2], fixMe[3])
        end
        wipe(self.fixProtectedFrames)
    end
end

function DeModalMixin:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        self:AddonLoadedEvent(...)
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:PlayerRegenEnabledEvent()
    end
end
