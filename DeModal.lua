local _, PKG = ...

-- global API for this addon
DEMODAL_ADDON = {}
DEMODAL_ADDON.VERSION_STRING = "DeModal @project-version@"
DEMODAL_ADDON.VERSION = "@project-version@"

-- load all the things
PKG.LoadSlashCommands()
PKG.SettingsMixin.Init()
PKG.DeModalMixin.Init()
