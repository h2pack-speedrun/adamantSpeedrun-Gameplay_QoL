return {
    option = {
        type = "checkbox",
        alias = "EscalatingFigLeaf",
        label = "Incrementing Fig Leaf",
        default = false,
        tooltip =
        "Dionysus Skip Chance starts at default value and increases by 13% after every encounter, resetting on biome start."
    },
    hooks = {
        function(module)
            module.hooks.wrap("DionysusSkipTrait", function(host, runtime, baseFunc, args, traitData)
                if not runtime.data.read("EscalatingFigLeaf") or not host.isEnabled() then
                    return baseFunc(args, traitData)
                end
                baseFunc(args, traitData)
                for _, trait in ipairs(CurrentRun.Hero.Traits) do
                    if trait.Name == "PersistentDionysusSkipKeepsake" then
                        trait.InitialSkipEncounterChance = trait.SkipEncounterChance
                        trait.SkipEncounterGrowthPerRoom = 0.13
                        break
                    end
                end
            end)

            module.hooks.wrap("EndEncounterEffects", function(host, runtime, baseFunc, currentRun, currentRoom, currentEncounter)
                if not runtime.data.read("EscalatingFigLeaf") or not host.isEnabled() then
                    return baseFunc(currentRun, currentRoom, currentEncounter)
                end
                baseFunc(currentRun, currentRoom, currentEncounter)
                if currentEncounter == currentRoom.Encounter or currentEncounter == MapState.EncounterOverride then
                    if HeroHasTrait("PersistentDionysusSkipKeepsake") then
                        local traitData = GetHeroTrait("PersistentDionysusSkipKeepsake")
                        if traitData.SkipEncounterChance and traitData.SkipEncounterGrowthPerRoom then
                            traitData.SkipEncounterChance = math.min(1,
                                traitData.SkipEncounterChance + traitData.SkipEncounterGrowthPerRoom)
                        end
                    end
                end
            end)

            module.hooks.wrap("StartRoom", function(host, runtime, baseFunc, currentRun, currentRoom)
                if not runtime.data.read("EscalatingFigLeaf") or not host.isEnabled() then
                    return baseFunc(currentRun, currentRoom)
                end
                baseFunc(currentRun, currentRoom)
                if currentRoom.BiomeStartRoom then
                    if HeroHasTrait("PersistentDionysusSkipKeepsake") then
                        local traitData = GetHeroTrait("PersistentDionysusSkipKeepsake")
                        if traitData.InitialSkipEncounterChance then
                            traitData.SkipEncounterChance = traitData.InitialSkipEncounterChance
                        end
                    end
                end
            end)
        end,
    },
}
