local behaviors = {
    patches = {},
    hooks = {},
    options = {},
}

local function register(path)
    local behavior = import(path)
    if behavior.option then
        table.insert(behaviors.options, behavior.option)
    end
    for _, patch in ipairs(behavior.patches or {}) do
        table.insert(behaviors.patches, patch)
    end
    for _, hook in ipairs(behavior.hooks or {}) do
        table.insert(behaviors.hooks, hook)
    end
end

register("behaviors/FamiliarDelayFix.lua")
register("behaviors/MiniBossEncounterFix.lua")
register("behaviors/SkipGemBossReward.lua")
register("behaviors/PreventEchoScam.lua")
register("behaviors/DisableSeleneBeforeBoon.lua")
register("behaviors/DisableArachnePity.lua")
register("behaviors/ForceArachne.lua")
register("behaviors/ForceMedea.lua")
register("behaviors/EscalatingFigLeaf.lua")

return behaviors
