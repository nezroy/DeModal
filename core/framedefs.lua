local _, PKG = ...

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    {["f"] = "CharacterFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "SpellBookFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "PVEFrame", ["retail"] = true, ["bcc"] = false, ["classic"] = false},
    {["f"] = "DressUpFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "FriendsFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "BankFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "MailFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "GossipFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "QuestFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "MerchantFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "TabardFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "GuildRegistrarFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "ItemTextFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "PetStableFrame", ["retail"] = true, ["bcc"] = true, ["classic"] = true},
    {["f"] = "GuildInviteFrame", ["retail"] = true, ["bcc"] = false, ["classic"] = false},
    {["f"] = "QuestLogFrame", ["retail"] = false, ["bcc"] = true, ["classic"] = true},
    {["f"] = "TaxiFrame", ["retail"] = false, ["bcc"] = true, ["classic"] = true}
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AchievementUI"] = {"AchievementFrame"},
    ["Blizzard_AnimaDiversionUI"] = {"AnimaDiversionFrame"},
    ["Blizzard_ArtifactUI"] = {"ArtifactFrame"},
    ["Blizzard_AuctionHouseUI"] = {"AuctionHouseFrame"},
    ["Blizzard_AuctionUI"] = {"AuctionFrame"}, -- bcc
    ["Blizzard_AzeriteEssenceUI"] = {"AzeriteEssenceUI"},
    ["Blizzard_Calendar"] = {"CalendarFrame"},
    ["Blizzard_Collections"] = {"CollectionsJournal", "WardrobeFrame"},
    ["Blizzard_CovenantRenown"] = {"CovenantRenownFrame"},
    ["Blizzard_CovenantSanctum"] = {"CovenantSanctumFrame"},
    ["Blizzard_Communities"] = {"CommunitiesFrame", "CommunitiesGuildLogFrame", "CommunitiesGuildTextEditFrame", "CommunitiesGuildNewsFiltersFrame"},
    ["Blizzard_EncounterJournal"] = {"EncounterJournal"},
    ["Blizzard_FlightMap"] = {"FlightMapFrame"},
    ["Blizzard_GarrisonUI"] = {"GarrisonMissionFrame", "GarrisonBuildingFrame", "GarrisonShipyardFrame", "GarrisonRecruiterFrame", "GarrisonRecruitSelectFrame", "GarrisonCapacitiveDisplayFrame", "OrderHallMissionFrame", "GarrisonLandingPage", "BFAMissionFrame", "CovenantMissionFrame"},
    ["Blizzard_GuildBankUI"] = {"GuildBankFrame"},
    ["Blizzard_GuildControlUI"] = {"GuildControlUI"},
    ["Blizzard_InspectUI"] = {"InspectFrame"},
    ["Blizzard_IslandsQueueUI"] = {"IslandsQueueFrame"},
    ["Blizzard_ItemSocketingUI"] = {"ItemSocketingFrame"},
    ["Blizzard_ItemUpgradeUI"] = {"ItemUpgradeFrame"},
    ["Blizzard_LookingForGroupUI"] = {"LFGParentFrame"}, -- bcc
    ["Blizzard_MacroUI"] = {"MacroFrame"},
    ["Blizzard_OrderHallUI"] = {"OrderHallTalentFrame"},
    ["Blizzard_RuneforgeUI"] = {"RuneforgeFrame"},
    ["Blizzard_ScrappingMachineUI"] = {"ScrappingMachineFrame"},
    ["Blizzard_Soulbinds"] = {"SoulbindViewer"},
    ["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
    ["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
    ["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
    ["Blizzard_VoidStorageUI"] = {"VoidStorageFrame"},
    ["Blizzard_WeeklyRewards"] = {"WeeklyRewardsFrame"},
    ["Blizzard_WorldMap"] = {"WorldMapFrame"}
}

-- frames with special header draggable handling
PKG.headerFrames = {
    ["AchievementFrame"] = "AchievementFrameHeader"
}

-- names of close buttons for frames where this is necessary
PKG.frameCloseButtons = {
    ["SpellBookFrame"] = {["name"] = "SpellBookFrameCloseButton", ["bcc"] = "SpellBookCloseButton"},
    ["CollectionsJournal"] = {["name"] = "CollectionsJournalCloseButton"}
}
