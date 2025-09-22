local _, PKG = ...

-- simple frames that should always be pre-loaded
PKG.frameXML = {
    "CharacterFrame", "PVEFrame", "DressUpFrame", "FriendsFrame",
    "BankFrame", "MailFrame", "GossipFrame", "QuestFrame",
    "MerchantFrame", "TabardFrame", "GuildRegistrarFrame", "ItemTextFrame",
    "LFGDungeonReadyDialog", "GuildInviteFrame", "ContainerFrameCombinedBags",
}

-- frames loaded with specific blizzard addons
PKG.addonFrames = {
    ["Blizzard_AchievementUI"] = {"AchievementFrame"},
    ["Blizzard_AlliedRacesUI"] = {"AlliedRacesFrame"},
    ["Blizzard_AnimaDiversionUI"] = {"AnimaDiversionFrame"},
    ["Blizzard_ArchaeologyUI"] = {"ArchaeologyFrame"},
    ["Blizzard_ArtifactUI"] = {"ArtifactFrame"},
    ["Blizzard_AuctionHouseUI"] = {"AuctionHouseFrame"},
    ["Blizzard_AzeriteEssenceUI"] = {"AzeriteEssenceUI"},
    ["Blizzard_AzeriteRespecUI"] = {"AzeriteRespecFrame"},
    ["Blizzard_AzeriteUI"] = {"AzeriteEmpoweredItemUI"},
    ["Blizzard_BlackMarketUI"] = {"BlackMarketFrame"},
    ["Blizzard_Calendar"] = {"CalendarFrame"},
    ["Blizzard_ChromieTimeUI"] = {"ChromieTimeFrame"},
    ["Blizzard_ClassTalentUI"] = {"ClassTalentFrame"},
    ["Blizzard_Collections"] = {"CollectionsJournal", "WardrobeFrame"},
    -- ["Blizzard_CovenantPreviewUI"] = {"CovenantPreviewFrame"}, -- no bueno
    ["Blizzard_CovenantRenown"] = {"CovenantRenownFrame"},
    ["Blizzard_CovenantSanctum"] = {"CovenantSanctumFrame"},
    ["Blizzard_Communities"] = {"CommunitiesFrame", "CommunitiesGuildLogFrame", "CommunitiesGuildTextEditFrame", "CommunitiesGuildNewsFiltersFrame"},
    ["Blizzard_EncounterJournal"] = {"EncounterJournal"},
    ["Blizzard_ExpansionLandingPage"] = {"ExpansionLandingPage"},
    ["Blizzard_FlightMap"] = {"FlightMapFrame"},
    ["Blizzard_GarrisonUI"] = {"GarrisonMissionFrame", "GarrisonBuildingFrame", "GarrisonShipyardFrame", "GarrisonRecruiterFrame", "GarrisonRecruitSelectFrame", "GarrisonCapacitiveDisplayFrame", "OrderHallMissionFrame", "GarrisonLandingPage", "BFAMissionFrame", "CovenantMissionFrame", "GarrisonMonumentFrame"},
    ["Blizzard_GenericTraitUI"] = {"GenericTraitFrame"},
    ["Blizzard_GuildBankUI"] = {"GuildBankFrame"},
    ["Blizzard_GuildControlUI"] = {"GuildControlUI"},
    ["Blizzard_InspectUI"] = {"InspectFrame"},
    ["Blizzard_IslandsQueueUI"] = {"IslandsQueueFrame"},
    ["Blizzard_ItemInteractionUI"] = {"ItemInteractionFrame"},
    ["Blizzard_ItemSocketingUI"] = {"ItemSocketingFrame"},
    ["Blizzard_ItemUpgradeUI"] = {"ItemUpgradeFrame"},
    ["Blizzard_MacroUI"] = {"MacroFrame"},
    ["Blizzard_MajorFactions"] = {"MajorFactionRenownFrame"},
    ["Blizzard_NewPlayerExperienceGuide"] = {"GuideFrame"},
    ["Blizzard_OrderHallUI"] = {"OrderHallTalentFrame"},
    ["Blizzard_PlayerSpells"] = {"PlayerSpellsFrame"},
    -- ["Blizzard_PlayerChoice"] = {"PlayerChoiceFrame"}, -- does not behave on re-open after move
    ["Blizzard_Professions"] = {"ProfessionsFrame"},
    ["Blizzard_ProfessionsBook"] = {"ProfessionsBookFrame"},
    ["Blizzard_ProfessionsCustomerOrders"] = {"ProfessionsCustomerOrdersFrame"},
    ["Blizzard_RuneforgeUI"] = {"RuneforgeFrame"},
    ["Blizzard_ScrappingMachineUI"] = {"ScrappingMachineFrame"},
    ["Blizzard_Soulbinds"] = {"SoulbindViewer"},
    ["Blizzard_StableUI"] = {"StableFrame"},
    ["Blizzard_TorghastLevelPicker"] = {"TorghastLevelPickerFrame"},
    ["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
    ["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
    ["Blizzard_WeeklyRewards"] = {"WeeklyRewardsFrame"},
    ["Blizzard_WorldMap"] = {"WorldMapFrame"},
    ["Blizzard_DelvesCompanionConfigurationFrame"] = {"DelvesCompanionConfigurationFrame", "DelvesCompanionAbilityListFrame"},
    ["Blizzard_DelvesDifficultyPicker"] = {"DelvesDifficultyPickerFrame"}
}

-- frames with special header draggable handling
PKG.headerFrames = {
    ["AchievementFrame"] = "AchievementFrameHeader",
    ["WorldMapFrame"] = "WorldMapTitleButton"
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
    ["WorldMapFrame"] = true
}

PKG.clearLabel = function(label)
    label:ClearPoint("RIGHT")
end

PKG.updateScaleForFit = function(f, fitWidth, fitHeight)
    UIPanelUpdateScaleForFit(f, fitWidth, fitHeight)
end
