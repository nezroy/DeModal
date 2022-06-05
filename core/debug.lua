local _, PKG = ...

local D = DLAPI -- the DebugLog addon
local P = Profiler -- the Stragglers CPU Profiler addon

local function EmptyFunc()
end

local function AddForProfiling(unit, name, ...)
    local gName = "DeModal_" .. unit
    if not _G[ gName ] then
        _G[ gName ] = {}
    end
    _G[ gName ][name] = ...
end

local function Debug(...)
    if not D then
        return
    end
    local msg = ""
    for i = 1, select("#", ...) do
        msg = msg .. tostring(select(i, ...)) .. " "
    end
    D.DebugLog("DeModal", "%s", msg)
end

local function Trace()
    if not D then
        return
    end
    D.DebugLog("DeModalTrace", "%s", "======== Trace ==")
    for i, v in ipairs({("\n"):split(debugstack(2))}) do
        if v ~= "" then
            D.DebugLog("DeModalTrace", "%d: %s", i, v)
        end
    end
    D.DebugLog("DeModalTrace", "%s", "-----------------")
end

if D then
    PKG.Debug = Debug
    PKG.Trace = Trace
    SetCVar("fstack_preferParentKeys", 0)
    Debug("DebugLog setup complete")
else
    PKG.Debug = EmptyFunc
    PKG.Trace = EmptyFunc
end

if P then
    PKG.AddForProfiling = AddForProfiling
    if D then
        AddForProfiling("debug", "AddForProfiling", AddForProfiling)
        AddForProfiling("debug", "Debug", Debug)
        AddForProfiling("debug", "Trace", Trace)
    end
    --_G.DeModal_addon_scope = PKG
else
    PKG.AddForProfiling = EmptyFunc
end
