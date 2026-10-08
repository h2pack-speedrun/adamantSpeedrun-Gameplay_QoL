local HADES_BOONS = {
    "",
    "HadesLifestealBoon",
    "HadesCastProjectileBoon",
    "HadesPreDamageBoon",
    "HadesChronosDebuffBoon",
    "HadesDashSweepBoon",
    "HadesDeathDefianceDamageBoon",
    "HadesManaUrnBoon",
    "HadesInvisibilityRetaliateBoon",
}

return {
    option = {
        type = "dropdown",
        alias = "JeweledPomBoon",
        label = "Jeweled Pom Boon",
        default = "",
        values = HADES_BOONS,
        tooltip =
        "Chooses which Hades boon the Jeweled Pom grants. Falls back to a random Hades boon if the chosen one is not eligible."
    },
    hooks = {
        function(module)
            module.hooks.wrap("GiveRandomHadesBoonAndBoostBoons", function(host, runtime, baseFunc, args, traitData)
                local chosen = runtime.data.read("JeweledPomBoon")
                if chosen == "" or not host.isEnabled() then
                    return baseFunc(args, traitData)
                end

                -- Vanilla sets this at the start of the function; the Death Defiance boon needs it to be eligible.
                if not CurrentRun.DeathDefianceDamageBoonEligible and GameState.MetaUpgradeState
                    and GameState.MetaUpgradeState.LastStand and GameState.MetaUpgradeState.LastStand.Equipped then
                    CurrentRun.DeathDefianceDamageBoonEligible = true
                end
                if not IsTraitEligible(TraitData[chosen]) or HeroHasTrait(chosen) then
                    return baseFunc(args, traitData)
                end

                -- The vanilla roll reads this list directly, and it also feeds Hades' own boon offers.
                local hades = UnitSetData.NPC_Hades.NPC_Hades_Field_01
                local originalTraits = hades.Traits
                hades.Traits = { chosen }
                local ok, err = pcall(baseFunc, args, traitData)
                hades.Traits = originalTraits
                if not ok then
                    error(err, 0)
                end
            end)
        end,
    },
}
