return {
    option = {
        type = "checkbox",
        alias = "MiniBossEncounterFix",
        label = "Miniboss Encounter Fix",
        default = true,
        tooltip =
        "Fixes Miniboss with top screen health bars not properly progressing biome depth."
    },
    patches = {
        {
            key = "MiniBossEncounterFix",
            fn = function(plan)
                plan:set(EncounterData.MiniBossBoar, "CountsForRoomEncounterDepth", true)
                plan:set(EncounterData.MiniBossCharybdis, "CountsForRoomEncounterDepth", true)
                plan:set(EncounterData.MiniBossTalos, "CountsForRoomEncounterDepth", true)
                plan:set(EncounterData.BossTyphonEye01, "CountsForRoomEncounterDepth", true)
                plan:set(EncounterData.BossTyphonArm01, "CountsForRoomEncounterDepth", true)
            end
        },
    },
}
