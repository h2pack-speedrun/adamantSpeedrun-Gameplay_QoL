return {
    option = {
        type = "checkbox",
        alias = "CorrosionFix",
        label = "Corrosion Fix",
        default = true,
        tooltip =
        "Fixes corrosion aggroing mobs on thessaly boats."
    },
    patches = {
        {
            key = "CorrosionFix",
            fn = function(plan)
                if not TraitData.ArmorPenaltyCurse then return end
                plan:set(TraitData.ArmorPenaltyCurse.OnEnemySpawnFunction.Args, "SkipOnDamagedPowers", true)
            end
        },
    },
}
