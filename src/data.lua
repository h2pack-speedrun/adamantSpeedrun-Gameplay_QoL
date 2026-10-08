local PACK_ID = "speedrun"

local data = {}

function data.buildStorage(options)
    local storage = {}
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            table.insert(storage, {
                type = "bool",
                alias = option.alias,
                default = option.default == true,
            })
        elseif option.type == "dropdown" then
            table.insert(storage, {
                type = "string",
                alias = option.alias,
                default = option.default,
                maxLen = 64,
            })
        else
            error(("Unsupported option type '%s' in %s"):format(tostring(option.type), PACK_ID .. ".Gameplay_QoL"))
        end
    end
    return storage
end

return data
