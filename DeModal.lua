local _, PKG = ...

local Debug = PKG.Debug

-- global API for this addon
DEMODAL_ADDON = {}
DEMODAL_ADDON.VERSION_STRING = "DeModal @project-version@"
DEMODAL_ADDON.VERSION = "@project-version@"

-- version ID stuff
PKG.gameVersion = "retail"
local tocv = select(4, GetBuildInfo())
if tocv < 20000 then
    PKG.gameVersion = "vanilla"
elseif tocv < 40000 then
    PKG.gameVersion = "wrath"
end
Debug("TOC V", tocv, PKG.gameVersion)

-- load all the things
PKG.LoadSlashCommands()

-- main addon & event frame
local MF = CreateFrame("Frame", nil, UIParent)
Mixin(MF, PKG.DeModalMixin)
MF:Init()
MF:SetScript("OnEvent", MF.OnEvent)
MF:RegisterEvent("ADDON_LOADED")
