local _, PKG = ...

local D = DLAPI -- the DebugLog addon

local function EmptyFunc()
end

local function Debug(...)
    local msg = ""
    for i = 1, select("#", ...) do
        msg = msg .. tostring(select(i, ...)) .. " "
    end
    D.DebugLog("DeModal", "%s", msg)
end

local function Trace()
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
