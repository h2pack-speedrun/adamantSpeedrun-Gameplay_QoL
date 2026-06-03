return {
    option = {
        type = "checkbox",
        alias = "ForceMedea",
        label = "Force Medea Spawn",
        default = false,
        tooltip =
        "Forces Medea to spawn to reduce death pity reset."
    },
    patches = {
        {
            key = "ForceMedea",
            fn = function(plan)
                plan:setMany(RoomSetData.N.N_Story01, {
                    ForceAtBiomeDepthMin = 0,
                    ForceAtBiomeDepthMax = 1,
                })
            end
        },
    },
}
