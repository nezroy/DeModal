local _, PKG = ...

-- feature flags
PKG.FF = {
    ["CombinedBags"] = true,
}

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    "CharacterFrame", "DressUpFrame", "FriendsFrame",
    "BankFrame", "MailFrame", "GossipFrame", "QuestFrame",
    "MerchantFrame", "TabardFrame", "GuildRegistrarFrame", "ItemTextFrame",
    "PetStableFrame", "LFGDungeonReadyDialog", "QuestLogFrame", "TaxiFrame",
    "ContainerFrameCombinedBags"
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AuctionUI"] = {"AuctionFrame"},
    ["Blizzard_Calendar"] = {"CalendarFrame"},
    ["Blizzard_ClassTalentUI"] = {"ClassTalentFrame"},
    ["Blizzard_Collections"] = {"CollectionsJournal", "WardrobeFrame"},
    ["Blizzard_Communities"] = {"CommunitiesFrame", "CommunitiesGuildLogFrame", "CommunitiesGuildTextEditFrame", "CommunitiesGuildNewsFiltersFrame", "ChannelFrame"},
    ["Blizzard_EncounterJournal"] = {"EncounterJournal"},
    ["Blizzard_ExpansionLandingPage"] = {"ExpansionLandingPage"},
    ["Blizzard_FlightMap"] = {"FlightMapFrame"},
    ["Blizzard_GenericTraitUI"] = {"GenericTraitFrame"},
    ["Blizzard_GuildBankUI"] = {"GuildBankFrame"},
    ["Blizzard_GuildControlUI"] = {"GuildControlUI"},
    ["Blizzard_InspectUI"] = {"InspectFrame"},
    ["Blizzard_ItemInteractionUI"] = {"ItemInteractionFrame"},
    ["Blizzard_ItemSocketingUI"] = {"ItemSocketingFrame"},
    ["Blizzard_ItemUpgradeUI"] = {"ItemUpgradeFrame"},
    ["Blizzard_MacroUI"] = {"MacroFrame"},
    ["Blizzard_NewPlayerExperienceGuide"] = {"GuideFrame"},
    ["Blizzard_PlayerSpells"] = {"PlayerSpellsFrame"},
    ["Blizzard_Professions"] = {"ProfessionsFrame"},
    ["Blizzard_StableUI"] = {"StableFrame"},
    ["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
    ["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
    ["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
    ["Blizzard_WeeklyRewards"] = {"WeeklyRewardsFrame"},
    ["Blizzard_WorldMap"] = {"WorldMapFrame"},
    ["Blizzard_CooldownViewer"] = {"CooldownViewerSettings"},
}

-- frames with special header draggable handling
PKG.headerFrames = {
    ["WorldMapFrame"] = "WorldMapTitleButton",
}

-- names of close buttons for frames where this is necessary
PKG.frameCloseButtons = {
    ["PlayerSpellsFrame"] = "PlayerSpellsFrameCloseButton",
    ["WorldMapFrame"] = "WorldMapFrameCloseButton",
    ["CollectionsJournal"] = "CollectionsJournalCloseButton",
}

-- frames that should be treated as protected even though IsProtected does not return true
PKG.treatAsProtected = {
}

PKG.clearLabel = function(label)
    label:ClearPointsByName("RIGHT")
end

PKG.updateScaleForFit = function(f, fitWidth, fitHeight)
    if FrameUtil and FrameUtil.UpdateScaleForFit then
        FrameUtil.UpdateScaleForFit(f, fitWidth, fitHeight)
    elseif UIPanelUpdateScaleForFit then
        UIPanelUpdateScaleForFit(f, fitWidth, fitHeight)
    end
end
