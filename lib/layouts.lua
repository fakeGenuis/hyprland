local M = {}

local layouts = { "dwindle", "master", "scrolling", "monocle" }

function M.cycle()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then
        return
    end

    local next_layout = layouts[1]

    for i, layout in ipairs(layouts) do
        if layout == workspace.tiled_layout then
            next_layout = layouts[i % #layouts + 1]
            break
        end
    end

    local selector = workspace.special and workspace.name or tostring(workspace.id)
    hl.workspace_rule({ workspace = selector, layout = next_layout })
end

return M
