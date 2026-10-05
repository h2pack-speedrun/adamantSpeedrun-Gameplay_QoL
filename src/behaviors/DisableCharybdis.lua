return {
    option = {
        type = "checkbox",
        alias = "DisableCharybdis",
        label = "Disable Charybdis",
        default = false,
        tooltip = "Prevents the Charybdis miniboss room from appearing on Thessaly.",
    },
    patches = {
        {
            key = "DisableCharybdis",
            fn = function(plan)
                plan:appendUnique(RoomData.O_MiniBoss01, "GameStateRequirements", {
                    Path = { "CurrentRun", "BiomeDepthCache" },
                    Comparison = "<",
                    Value = 0,
                })
            end
        },
    },
}
