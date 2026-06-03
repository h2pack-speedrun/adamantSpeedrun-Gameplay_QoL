return {
    option = {
        type = "checkbox",
        alias = "DisableArachnePity",
        label = "Disable Arachne Pity",
        default = false,
        tooltip =
        "Disables Arachne Pity entirely for Anyfear runs."
    },
    patches = {
        {
            key = "DisableArachnePity",
            fn = function(plan)
                plan:set(RoomSetData.F.F_Story01, "ForceIfUnseenForRuns", nil)
            end
        },
    },
}
