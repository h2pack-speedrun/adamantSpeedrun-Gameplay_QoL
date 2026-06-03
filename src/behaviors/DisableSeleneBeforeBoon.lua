return {
    option = {
        type = "checkbox",
        alias = "DisableSeleneBeforeBoon",
        label = "Disable Selene Before First Boon",
        default = false,
        tooltip =
        "Prevents Selene from spawning before the first boon is obtained."
    },
    patches = {
        {
            key = "DisableSeleneBeforeBoon",
            fn = function(plan)
                local additionalSpellReq = {
                    Path = { "CurrentRun", "LootTypeHistory" },
                    CountOf = {
                        "AphroditeUpgrade", "ApolloUpgrade", "DemeterUpgrade",
                        "HephaestusUpgrade", "HestiaUpgrade", "HeraUpgrade",
                        "PoseidonUpgrade", "ZeusUpgrade", "AresUpgrade", "WeaponUpgrade"
                    },
                    Comparison = ">=",
                    Value = 1
                }
                if NamedRequirementsData and NamedRequirementsData.SpellDropRequirements then
                    plan:appendUnique(NamedRequirementsData, "SpellDropRequirements", additionalSpellReq)
                end
            end
        },
    },
}
