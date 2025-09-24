local _, PKG = ...

-- feature flags
PKG.FF = {
    ["CombinedBags"] = false,
}

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    "CharacterFrame", "SpellBookFrame", "DressUpFrame", "FriendsFrame",
    "BankFrame", "MailFrame", "GossipFrame", "QuestFrame",
    "MerchantFrame", "TabardFrame", "GuildRegistrarFrame", "ItemTextFrame",
    "PetStableFrame", "LFGDungeonReadyDialog", "QuestLogFrame", "TaxiFrame",
    "PVEFrame", "QuestLogDetailFrame",
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AchievementUI"] = {"AchievementFrame"},
    ["Blizzard_ArchaeologyUI"] = {"ArchaeologyFrame"},
    ["Blizzard_AuctionHouseUI"] = {"AuctionHouseFrame"},
    ["Blizzard_BlackMarketUI"] = {"BlackMarketFrame"},
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
    ["Blizzard_LookingForGroupUI"] = {"LFGParentFrame"},
    ["Blizzard_MacroUI"] = {"MacroFrame"},
    ["Blizzard_NewPlayerExperienceGuide"] = {"GuideFrame"},
    ["Blizzard_ReforgingUI"] = {"ReforgingFrame"},
    ["Blizzard_StableUI"] = {"StableFrame"},
    ["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
    ["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
    ["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
    ["Blizzard_WeeklyRewards"] = {"WeeklyRewardsFrame"},
    ["Blizzard_WorldMap"] = {"WorldMapFrame"}
}

-- frames with special header draggable handling
PKG.headerFrames = {
    ["AchievementFrame"] = "AchievementFrameHeader",
    ["WorldMapFrame"] = "WorldMapTitleButton",
    ["ReforgingFrame"] = ".TitleContainer",
}

-- names of close buttons for frames where this is necessary
PKG.frameCloseButtons = {
    ["SpellBookFrame"] = "SpellBookFrameCloseButton",
    ["CollectionsJournal"] = "CollectionsJournalCloseButton",
    ["PlayerSpellsFrame"] = "PlayerSpellsFrameCloseButton",
    ["WorldMapFrame"] = "WorldMapFrameCloseButton"
}

-- frames that should be treated as protected even though IsProtected does not return true
PKG.treatAsProtected = {
}

PKG.clearLabel = function(label)
    label:ClearPoint("RIGHT")
end

PKG.updateScaleForFit = function(f, fitWidth, fitHeight)
    FrameUtil.UpdateScaleForFit(f, fitWidth, fitHeight)
end
