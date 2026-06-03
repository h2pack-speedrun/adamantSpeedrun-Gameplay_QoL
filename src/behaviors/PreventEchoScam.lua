return {
    option = {
        type = "checkbox",
        alias = "PreventEchoScam",
        label = "Prevent Echo Scam",
        default = false,
        tooltip =
        "Prevents Echo scam by blocking both minibosses from spawning at room 3."
    },
    patches = {
        {
            key = "PreventEchoScam",
            fn = function(plan)
                local newReq = {
                    Path = { "CurrentRun", "BiomeDepthCache" },
                    Comparison = "!=",
                    Value = 3,
                }
                for _, roomName in ipairs({ "H_MiniBoss01", "H_MiniBoss02" }) do
                    plan:appendUnique(RoomData[roomName], "GameStateRequirements", newReq)
                end
            end
        },
    },
}
