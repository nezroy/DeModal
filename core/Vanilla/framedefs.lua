local _, PKG = ...

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    "CharacterFrame", "SpellBookFrame", "DressUpFrame", "FriendsFrame",
    "BankFrame", "MailFrame", "GossipFrame", "QuestFrame",
    "MerchantFrame", "TabardFrame", "GuildRegistrarFrame", "ItemTextFrame",
    "PetStableFrame", "LFGDungeonReadyDialog", "QuestLogFrame", "TaxiFrame",
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AuctionUI"] = {"AuctionFrame"},
    ["Blizzard_Calendar"] = {"CalendarFrame"},
    ["Blizzard_ClassTalentUI"] = {"ClassTalentFrame"},
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
    ["Blizzard_StableUI"] = {"StableFrame"},
    ["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
    ["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
    ["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
    ["Blizzard_WeeklyRewards"] = {"WeeklyRewardsFrame"},
    ["Blizzard_WorldMap"] = {"WorldMapFrame"}
}

-- frames with special header draggable handling
PKG.headerFrames = {
    ["WorldMapFrame"] = "WorldMapTitleButton"
}

-- names of close buttons for frames where this is necessary
PKG.frameCloseButtons = {
    ["SpellBookFrame"] = "SpellBookCloseButton",
    ["WorldMapFrame"] = "WorldMapFrameCloseButton"
}

-- frames that should be treated as protected even though IsProtected does not return true
PKG.treatAsProtected = {
}

PKG.clearLabel = function(label)
    label:ClearPointsByName("RIGHT")
end

PKG.updateScaleForFit = function(f, fitWidth, fitHeight)
    FrameUtil.UpdateScaleForFit(f, fitWidth, fitHeight)
end
