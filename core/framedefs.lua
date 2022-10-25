local _, PKG = ...

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    {["f"] = "CharacterFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "SpellBookFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "PVEFrame", ["retail"] = true, ["wrath"] = false, ["tbc"] = false, ["vanilla"] = false},
    {["f"] = "DressUpFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "FriendsFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "BankFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "MailFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "GossipFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "QuestFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "MerchantFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "TabardFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "GuildRegistrarFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "ItemTextFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "PetStableFrame", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "LFGDungeonReadyDialog", ["retail"] = true, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "GuildInviteFrame", ["retail"] = true, ["wrath"] = false, ["tbc"] = false, ["vanilla"] = false},
    {["f"] = "QuestLogFrame", ["retail"] = false, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true},
    {["f"] = "TaxiFrame", ["retail"] = false, ["wrath"] = true, ["tbc"] = true, ["vanilla"] = true}
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AchievementUI"] = {"AchievementFrame"},
    ["Blizzard_AnimaDiversionUI"] = {"AnimaDiversionFrame"},
    ["Blizzard_ArtifactUI"] = {"ArtifactFrame"},
    ["Blizzard_AuctionHouseUI"] = {"AuctionHouseFrame"},
    ["Blizzard_AuctionUI"] = {"AuctionFrame"}, -- tbc
    ["Blizzard_AzeriteEssenceUI"] = {"AzeriteEssenceUI"},
    ["Blizzard_Calendar"] = {"CalendarFrame"},
    ["Blizzard_ClassTalentUI"] = {"ClassTalentFrame"},
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
    ["Blizzard_LookingForGroupUI"] = {"LFGParentFrame"}, -- tbc
    ["Blizzard_MacroUI"] = {"MacroFrame"},
    ["Blizzard_OrderHallUI"] = {"OrderHallTalentFrame"},
    ["Blizzard_RuneforgeUI"] = {"RuneforgeFrame"},
    ["Blizzard_ScrappingMachineUI"] = {"ScrappingMachineFrame"},
    ["Blizzard_Soulbinds"] = {"SoulbindViewer"},
    ["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
    ["Blizzard_TorghastLevelPicker"] = {"TorghastLevelPickerFrame"},
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
    ["SpellBookFrame"] = {["name"] = "SpellBookFrameCloseButton", ["wrath"] = "SpellBookCloseButton", ["tbc"] = "SpellBookCloseButton"},
    ["CollectionsJournal"] = {["name"] = "CollectionsJournalCloseButton"}
}
