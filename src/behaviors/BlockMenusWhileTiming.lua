-- The Codex, the Inventory, and the trait tray's Info screens (Path of Stars, familiar) pause
-- the in-game timer while open (UILogic.lua OnScreenOpened). During an active run they can
-- only be opened while the timer is already paused; the Crossroads is unaffected.
local function igtTicking()
    return CurrentRun ~= nil and CurrentHubRoom == nil
        and not CurrentRun.Hero.IsDead and not HasTimerBlock(CurrentRun)
end

local function blocked(host, runtime)
    return runtime.data.read("BlockMenusWhileTiming") and host.isEnabled() and igtTicking()
end

return {
    option = {
        type = "checkbox",
        alias = "BlockMenusWhileTiming",
        label = "Block Menus While Timing",
        default = true,
        tooltip =
        "The Codex, Inventory and trait Info screens pause the in-game timer, so during a run they can only be opened while it is already paused."
    },
    hooks = {
        function(module)
            -- The native control handlers show the game's own refusal when these return false.
            module.hooks.wrap("CanOpenCodex", function(host, runtime, baseFunc)
                if blocked(host, runtime) then return false end
                return baseFunc()
            end)

            module.hooks.wrap("CanOpenInventoryScreen", function(host, runtime, baseFunc)
                if blocked(host, runtime) then return false end
                return baseFunc()
            end)

            module.hooks.wrap("TraitTrayShouldShowInfoButton", function(host, runtime, baseFunc, screen, button)
                if blocked(host, runtime) then return false end
                return baseFunc(screen, button)
            end)
        end,
    },
}
