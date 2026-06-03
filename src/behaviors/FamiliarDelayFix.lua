return {
    option = {
        type = "checkbox",
        alias = "FamiliarDelayFix",
        label = "Familiar Delay Fix",
        default = true,
        tooltip =
        "Fixes Familiars being summoned after a delay upon entering a room."
    },
    patches = {
        {
            key = "FamiliarDelayFix",
            fn = function(plan)
                plan:transform(RoomEventData, "GlobalRoomInputUnblockedEvents", function(unblocked)
                    local copy = rom.game.DeepCopyTable(unblocked or {})
                    for _, event in ipairs(copy) do
                        if event.FunctionName == "FamiliarSetup" then
                            event.Args = {}
                            break
                        end
                    end
                    return copy
                end)
            end
        },
    },
}
