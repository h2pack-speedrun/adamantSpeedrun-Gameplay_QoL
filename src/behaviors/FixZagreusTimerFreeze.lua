-- Zagreus's death-defiance presentation pauses the run timer and resumes it only after a
-- wait tagged with his AI thread (EventPresentation.lua ZagreusDeathDefiancePresentation).
-- Killing him during that wait kills the thread, so the run-scoped block is never removed.
local BLOCK = "ZagreusDeathDefiancePresentation"

local function clearStaleBlock()
    if CurrentRun.BlockTimerFlags[BLOCK] then
        RemoveTimerBlock(CurrentRun, BLOCK)
    end
end

return {
    option = {
        type = "checkbox",
        alias = "FixZagreusTimerFreeze",
        label = "Fix Zagreus Timer Freeze",
        default = true,
        tooltip =
        "Resumes the run timer when Zagreus is killed right after he rises again, which otherwise leaves it paused for the rest of the run."
    },
    hooks = {
        function(module)
            module.hooks.wrap("Kill", function(host, runtime, baseFunc, victim, triggerArgs)
                local result = baseFunc(victim, triggerArgs)
                if runtime.data.read("FixZagreusTimerFreeze") and host.isEnabled()
                    and victim.Name == "Zagreus" then
                    clearStaleBlock()
                end
                return result
            end)

            -- Repairs a run that already carries the stale block, e.g. from a save.
            module.hooks.wrap("StartRoom", function(host, runtime, baseFunc, currentRun, currentRoom)
                if runtime.data.read("FixZagreusTimerFreeze") and host.isEnabled()
                    and not currentRoom.Name:match("^C_Boss") then
                    clearStaleBlock()
                end
                return baseFunc(currentRun, currentRoom)
            end)
        end,
    },
}
