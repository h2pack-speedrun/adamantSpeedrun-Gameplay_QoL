local bannedEncounters = {
    HeraclesCombatO = true,
    HeraclesCombatO2 = true,
}

return {
    option = {
        type = "checkbox",
        alias = "RemoveSurfaceHeracles",
        label = "Remove Thessaly Heracles",
        default = false,
        tooltip = "Removes Heracles encounter options from Thessaly.",
    },
    hooks = {
        function(module)
            module.hooks.wrap("ChooseEncounter", function(host, runtime, baseFunc, currentRun, room, args)
                if not runtime.data.read("RemoveSurfaceHeracles") or not host.isEnabled() then
                    return baseFunc(currentRun, room, args)
                end
                args = args or {}
                local source = args.LegalEncounters or room.LegalEncounters
                if source then
                    local filtered = {}
                    for _, enc in pairs(source) do
                        if not bannedEncounters[enc] then
                            table.insert(filtered, enc)
                        end
                    end
                    args.LegalEncounters = filtered
                end
                return baseFunc(currentRun, room, args)
            end)
        end,
    },
}
