local M = {}

function M.focus_numbered(step)
    local current = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not current then
        return
    end

    -- Cycle through occupied numbered workspaces plus one trailing empty slot.
    local ids = {}

    for _, workspace in ipairs(hl.get_workspaces()) do
        if workspace.id > 0 and not workspace.is_empty then
            ids[#ids + 1] = workspace.id
        end
    end

    table.sort(ids)
    ids[#ids + 1] = (ids[#ids] or 0) + 1

    local index

    for i, id in ipairs(ids) do
        if id == current.id then
            index = i
            break
        end
    end

    -- Enter the cycle at its start/end when leaving a named or special workspace.
    index = index or (step > 0 and 0 or #ids)

    local target = ids[(index - 1 + step) % #ids + 1]
    hl.dispatch(hl.dsp.focus({ workspace = target }))
end

return M
