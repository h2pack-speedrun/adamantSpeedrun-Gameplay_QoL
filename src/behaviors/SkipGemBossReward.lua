return {
    option = {
        type = "checkbox",
        alias = "SkipGemBossReward",
        label = "Skip Gem Boss Reward",
        default = false,
        tooltip =
        "Bosses no longer drop gem rewards when using Grave Thirst."
    },
    hooks = {
        function(module)
            module.hooks.wrap("UnusedWeaponBonusDropGems", function(host, runtime, baseFunc, source, args)
                if not runtime.data.read("SkipGemBossReward") or not host.isEnabled() then
                    return baseFunc(source, args)
                end
                return
            end)
        end,
    },
}
