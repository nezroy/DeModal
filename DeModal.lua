local _, PKG = ...

local Debug = PKG.Debug
local AFP = PKG.AddForProfiling

-- global API for this addon
DEMODAL_ADDON = {}
DEMODAL_ADDON.VERSION_STRING = "DeModal 0.5.0"

 -- main event frame
local MF = CreateFrame("Frame", nil, UIParent)

-- flag tracking whether addon has finished initial loading
local loaded = false

-- flag tracking if BetterWardrobe addon is present
local hasBetterWardrobe = false

-- protected frames that we only try to mass-close out of combat
local uiProtectedFrames = {}

-- protected frames that need deferred hook because they were initially loaded in combat
local fixProtectedFrames = {}

-- simple frames that should always be pre-loaded
local frameXML = {
    "CharacterFrame",
    "SpellBookFrame",
    "PVEFrame",
    "DressUpFrame",
    "FriendsFrame",
    "BankFrame",
    "MailFrame",
    "GossipFrame",
    "QuestFrame",
    "MerchantFrame",
    "TabardFrame",
    "GuildRegistrarFrame",
    "ItemTextFrame",
    "PetStableFrame",
    "GuildInviteFrame"
}

-- frames loaded with specific blizzard addons
local addonFrames = {
    Blizzard_AchievementUI = {"AchievementFrame"},
    Blizzard_AnimaDiversionUI = {"AnimaDiversionFrame"},
    Blizzard_ArtifactUI = {"ArtifactFrame"},
    Blizzard_AuctionHouseUI = {"AuctionHouseFrame"},
    Blizzard_AzeriteEssenceUI = {"AzeriteEssenceUI"},
    Blizzard_Calendar = {"CalendarFrame"},
    Blizzard_Collections = {"CollectionsJournal", "WardrobeFrame"},
    Blizzard_CovenantRenown = {"CovenantRenownFrame"},
    Blizzard_CovenantSanctum = {"CovenantSanctumFrame"},
    Blizzard_Communities = {"CommunitiesFrame", "CommunitiesGuildLogFrame", "CommunitiesGuildTextEditFrame", "CommunitiesGuildNewsFiltersFrame"},
    Blizzard_EncounterJournal = {"EncounterJournal"},
    Blizzard_FlightMap = {"FlightMapFrame"},
    Blizzard_GarrisonUI = {"GarrisonMissionFrame", "GarrisonBuildingFrame", "GarrisonShipyardFrame", "GarrisonRecruiterFrame", "GarrisonRecruitSelectFrame", "GarrisonCapacitiveDisplayFrame", "OrderHallMissionFrame", "GarrisonLandingPage", "BFAMissionFrame", "CovenantMissionFrame"},
    Blizzard_GuildBankUI = {"GuildBankFrame"},
    Blizzard_GuildControlUI = {"GuildControlUI"},
    Blizzard_InspectUI = {"InspectFrame"},
    Blizzard_IslandsQueueUI = {"IslandsQueueFrame"},
    Blizzard_ItemSocketingUI = {"ItemSocketingFrame"},
    Blizzard_ItemUpgradeUI = {"ItemUpgradeFrame"},
    Blizzard_MacroUI = {"MacroFrame"},
    Blizzard_OrderHallUI = {"OrderHallTalentFrame"},
    Blizzard_RuneforgeUI = {"RuneforgeFrame"},
    Blizzard_ScrappingMachineUI = {"ScrappingMachineFrame"},
    Blizzard_Soulbinds = {"SoulbindViewer"},
    Blizzard_TalentUI = {"PlayerTalentFrame"},
    Blizzard_TradeSkillUI = {"TradeSkillFrame"},
    Blizzard_TrainerUI = {"ClassTrainerFrame"},
    Blizzard_VoidStorageUI = {"VoidStorageFrame"},
    Blizzard_WeeklyRewards = {"WeeklyRewardsFrame"},
    Blizzard_WorldMap = {"WorldMapFrame"}
}

-- frames with special header draggable handling
local headerFrames = {
    ["AchievementFrame"] = "AchievementFrameHeader"
}

local function hookCloseWindows(ignoreCenter, frameToIgnore)
    if InCombatLockdown() then
        return
    end
    for i = 1, #uiProtectedFrames do
        local f = _G[ uiProtectedFrames[i] ]
        if f and (not frameToIgnore or frameToIgnore ~= f) then
            f:Hide()
        end
    end
end
AFP("main", "hookCloseWindows", hookCloseWindows)

local function protectedRaise_OnShow(self)
    if not InCombatLockdown() then
         self:Raise()
    end
end
AFP("main", "protectedRaise_OnShow", protectedRaise_OnShow)

local function protectedDebugMethod(self, ...)
    Debug(...)
end
AFP("main", "protectedDebugMethod", protectedDebugMethod)

local protectedEsc_OnShow = [=[
    local keyEsc = GetBindingKey("TOGGLEGAMEMENU")
    local clsBtn = self:GetAttribute("CloseButtonName")
    if clsBtn and keyEsc ~= nil then
        --self:CallMethod("Debug", "set close button", clsBtn)
        self:SetBindingClick(false, keyEsc, clsBtn)
    end
]=]

local protectedEsc_OnHide = [=[
    self:ClearBindings()
]=]

local function hookMovable(f, fName, wasArea)
    if f:IsProtected() and InCombatLockdown() then
        Debug("defer hook of movable frame:", fName)
        local setWasArea = false
        if (fName ~= "CollectionsJournal" or hasBetterWardrobe) and UIPanelWindows[fName] and UIPanelWindows[fName]["area"] then
            -- disable default panel positioning for this frame
            UIPanelWindows[fName]["area"] = nil
            setWasArea = true
        end
        tinsert(fixProtectedFrames, {f, fName, setWasArea})
        MF:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    else
        Debug("hook movable frame:", fName)
    end

    if fName == "CollectionsJournal" then
        f:SetFrameStrata("MEDIUM")
        if not hasBetterWardrobe then
            -- TODO: making collectionsjournal movable only works when BetterWardrobe is also
            -- installed; no clue why, I assume it does something wonky to the frame that I
            -- don't understand how to replicate yet
            return
        end
    end

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
        if fName == "EncounterJournal" then
            f:SetPoint("TOPLEFT", UIParent)
        else
            f:SetPoint("CENTER", UIParent)
        end
    end

    if fName == "EncounterJournal" and EncounterJournalTooltip then
        EncounterJournalTooltip:ClearAllPoints()
    end

    if wasArea or (UIPanelWindows[fName] and UIPanelWindows[fName]["area"]) then
        -- disable default panel positioning for this frame
        UIPanelWindows[fName]["area"] = nil
        --Debug("in panel thing", f:GetAttribute("UIPanelLayout-defined"), f:GetAttribute("UIPanelLayout-area"), f:GetNumPoints())
        if not f:IsProtected() then
            -- add to list of special frames that get auto-closed with ESC
            tinsert(UISpecialFrames, fName)
        else
            -- special handling required for ESC on protected frames
            Debug("frame is protected, need special ESC handler:", fName)
            tinsert(uiProtectedFrames, fName)
            local lp = CreateFrame("Frame", nil, f, "SecureHandlerShowHideTemplate")
            lp:ClearAllPoints()
            lp:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
            lp:SetSize(2, 2)
            lp.Debug = protectedDebugMethod
            if fName == "SpellBookFrame" then
                lp:SetAttribute("CloseButtonName", "SpellBookFrameCloseButton")
            elseif fName == "CollectionsJournal" then
                lp:SetAttribute("CloseButtonName", "CollectionsJournalCloseButton")
            end
            lp:SetAttribute("_onshow", protectedEsc_OnShow)
            lp:SetAttribute("_onhide", protectedEsc_OnHide)
        end
    end
end
AFP("main", "hookMovable", hookMovable)

local function hookMovableHeader(f, hf)
    if not f or not hf then
        return
    end
    Debug("hook movable header for frame:", hf:GetName())
    hf:EnableMouse(true)
    hf:HookScript("OnDragStart", function () f:StartMoving() end)
    hf:HookScript("OnDragStop", function () f:StopMovingOrSizing() end)
    hf:RegisterForDrag("LeftButton")
end
AFP("main", "hookMovableHeader", hookMovableHeader)

local function onAddonLoaded(self, addOnName)
    if addOnName == "DeModal" then
        if loaded then
            return
        end

        Debug("DeModal ADDON_LOADED event")

        PKG.LoadSlashCommands()

        -- check for BetterWardrobe
        local _, _, _, enabled, _ = GetAddOnInfo("BetterWardrobe")
        if enabled then
            hasBetterWardrobe = true
        end

        -- hook CloseWindows for special handling of protected frames
        hooksecurefunc("CloseWindows", hookCloseWindows)

        -- hook pre-loaded simple frames
        for i = 1, #frameXML do
            local fName = frameXML[i]
            local f = _G[ fName ]
            if f then
                hookMovable(f, fName)
            else
                Debug("missing frame that should not be missing:", fName)
            end
        end

        -- hook addon-based frames that might already be loaded
        for aName, fList in pairs(addonFrames) do
            for _, fName in ipairs(fList) do
                local f = _G[ fName ]
                if f then
                    hookMovable(f, fName)
                    if headerFrames[fName] then
                        -- dumb way to handle special frames that need extra work
                        hookMovableHeader(f, _G[ headerFrames[fName] ])
                    end
                    addonFrames[aName] = nil
                end
            end
        end

        loaded = true
        Debug("DeModal loaded")

    elseif addonFrames[addOnName] then
        if not loaded then
            return
        end
        Debug("addon load event for:", addOnName)
        local fList = addonFrames[addOnName]
        for _, fName in ipairs(fList) do
            local f = _G[ fName ]
            if f then
                hookMovable(f, fName)
                if headerFrames[fName] then
                    -- dumb way to handle special frames that need extra work
                    hookMovableHeader(f, _G[ headerFrames[fName] ])
                end
            else
                Debug("missing frame that should not be missing:", fName)
            end
        end
        addonFrames[addOnName] = nil

    end
end
AFP("main", "onAddonLoaded", onAddonLoaded)

-- handles addon loading
local function onEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        onAddonLoaded(self, ...)
    elseif event == "PLAYER_REGEN_ENABLED" then
        if not InCombatLockdown() then
            self:UnregisterEvent("PLAYER_REGEN_ENABLED")
            if #fixProtectedFrames > 0 then
                for i = 1, #fixProtectedFrames do
                    local f = fixProtectedFrames[i][1]
                    f:Hide()
                    hookMovable(f, fixProtectedFrames[i][2], fixProtectedFrames[i][3])
                end
                wipe(fixProtectedFrames)
            end
        end
    end
end
AFP("main", "onEvent", onEvent)
MF:SetScript("OnEvent", onEvent)
MF:RegisterEvent("ADDON_LOADED")
