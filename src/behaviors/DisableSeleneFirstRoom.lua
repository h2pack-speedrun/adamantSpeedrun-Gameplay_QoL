return {
    option = {
        type = "checkbox",
        alias = "DisableSeleneFirstRoom",
        label = "No Selene in First Room",
        default = false,
        tooltip =
        "Removes Selene from the reward roster of the first room of a run, including Dream Dive starts."
    },
    patches = {
        {
            key = "DisableSeleneFirstRoom",
            fn = function(plan)
                -- Opening/intro rooms of every biome reference this shared list directly.
                plan:appendUnique(RewardSets, "OpeningRoomBans", "SpellDrop")
                -- Erebus openings 02/03 inherited deep copies of the list at load.
                for _, roomName in ipairs({ "F_Opening02", "F_Opening03" }) do
                    plan:appendUnique(RoomData[roomName], "IneligibleRewards", "SpellDrop")
                end
            end
        },
    },
}
