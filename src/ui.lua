-- luacheck: globals TraitData

local module = {}

local DROPDOWN_WIDTH = 300

local function buildDisplayValues(option)
    local displayValues = {}
    for _, value in ipairs(option.values) do
        if value == "" then
            displayValues[value] = "None (Random)"
        else
            local traitData = TraitData and TraitData[value]
            local localized = game and game.GetDisplayName
                and game.GetDisplayName({ Text = traitData and traitData.Name or value }) or nil
            displayValues[value] = localized or value
        end
    end
    return displayValues
end

local function buildWidgetOptions(options)
    local optsByAlias = {}
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            optsByAlias[option.alias] = {
                label = option.label,
                tooltip = option.tooltip,
            }
        elseif option.type == "dropdown" then
            optsByAlias[option.alias] = {
                label = option.label,
                tooltip = option.tooltip,
                values = option.values,
                displayValues = buildDisplayValues(option),
                controlWidth = DROPDOWN_WIDTH,
            }
        end
    end
    return optsByAlias
end

local function drawOptions(draw, state, options, widgetOptsByAlias)
    for _, option in ipairs(options) do
        if option.type == "checkbox" then
            draw.widgets.checkbox(state.get(option.alias), widgetOptsByAlias[option.alias])
        elseif option.type == "dropdown" then
            draw.widgets.dropdown(state.get(option.alias), widgetOptsByAlias[option.alias])
        end
    end
end

function module.drawTab(draw, state, options, widgetOptsByAlias)
    drawOptions(draw, state, options, widgetOptsByAlias)
end

function module.attach(libModule, options)
    local widgetOptsByAlias = buildWidgetOptions(options)
    libModule.ui.tab(function(_, ui)
        return module.drawTab(ui.draw, ui.data, options, widgetOptsByAlias)
    end)
end

return module
