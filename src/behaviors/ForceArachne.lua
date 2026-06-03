return {
    option = {
        type = "checkbox",
        alias = "ForceArachne",
        label = "Force Arachne Spawn",
        default = false,
        tooltip =
        "Forces Arachne to spawn to reduce death pity reset."
    },
    patches = {
        {
            key = "ForceArachne",
            fn = function(plan)
                plan:setMany(RoomSetData.F.F_Story01, {
                    ForceAtBiomeDepthMin = 4,
                    ForceAtBiomeDepthMax = 8,
                })
            end
        },
    },
}
