local M = {}

function M.cycle_next()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then
        return
    end

    local windows = hl.get_workspace_windows(workspace)
    if #windows == 0 then
        return
    end

    table.sort(windows, function(a, b)
        return a.stable_id < b.stable_id
    end)

    local active = hl.get_active_window()
    local index = 0

    if active then
        for i, window in ipairs(windows) do
            if window.stable_id == active.stable_id then
                index = i
                break
            end
        end
    end

    local target = windows[index % #windows + 1]
    hl.dispatch(hl.dsp.focus({ window = target }))

    if target.floating then
        hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top", window = target }))
    end
end

return M
