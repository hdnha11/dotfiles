windowModal = hs.hotkey.modal.new()
local modalPackage = {}
modalPackage.id = 'windowModal'
modalPackage.modal = windowModal
table.insert(modalList, modalPackage)

local sizes = {2, 3, 3 / 2}
local fullScreenSizes = {1, 4 / 3, 2}

local GRID = {w = 24, h = 24}
hs.grid.setGrid(GRID.w .. 'x' .. GRID.h)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

local pressed = {
    up = false,
    down = false,
    left = false,
    right = false
}

function windowModal:entered()
    for i = 1, #modalList do
        if modalList[i].id == 'windowModal' then
            table.insert(activeModals, modalList[i])
        end
    end

    if hotkeyText then
        hotkeyText:delete()
        hotkeyText = nil
        hotkeyBackground:delete()
        hotkeyBackground = nil
    end

    if showWindowTips == nil then showWindowTips = true end
    if showWindowTips == true then showAvailableHotkey() end
end

function windowModal:exited()
    for i = 1, #activeModals do
        if activeModals[i].id == 'windowModal' then
            table.remove(activeModals, i)
        end
    end

    if hotkeyText then
        hotkeyText:delete()
        hotkeyText = nil
        hotkeyBackground:delete()
        hotkeyBackground = nil
    end
end

function nextStep(dim, offs, cb)
    if hs.window.focusedWindow() then
        local axis = dim == 'w' and 'x' or 'y'
        local oppDim = dim == 'w' and 'h' or 'w'
        local oppAxis = dim == 'w' and 'y' or 'x'
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        local nextSize = sizes[1]
        for i = 1, #sizes do
            if cell[dim] == GRID[dim] / sizes[i] and
                (cell[axis] + (offs and cell[dim] or 0)) == (offs and GRID[dim] or 0)
            then
                nextSize = sizes[(i % #sizes) + 1]
                break
            end
        end

        cb(cell, nextSize)
        if cell[oppAxis] ~= 0 and cell[oppAxis] + cell[oppDim] ~= GRID[oppDim] then
            cell[oppDim] = GRID[oppDim]
            cell[oppAxis] = 0
        end

        hs.grid.set(win, cell, screen)
    end
end

function nextFullScreenStep()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        local nextSize = fullScreenSizes[1]
        for i = 1, #fullScreenSizes do
            if cell.w == GRID.w / fullScreenSizes[i] and
                cell.h == GRID.h / fullScreenSizes[i] and
                cell.x == (GRID.w - GRID.w / fullScreenSizes[i]) / 2 and
                cell.y == (GRID.h - GRID.h / fullScreenSizes[i]) / 2 then
                nextSize = fullScreenSizes[(i % #fullScreenSizes) + 1]
                break
            end
        end

        cell.w = GRID.w / nextSize
        cell.h = GRID.h / nextSize
        cell.x = (GRID.w - GRID.w / nextSize) / 2
        cell.y = (GRID.h - GRID.h / nextSize) / 2

        hs.grid.set(win, cell, screen)
    end
end

function fullDimension(dim)
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()
        cell = hs.grid.get(win, screen)

        if (dim == 'x') then
            cell = '0,0 ' .. GRID.w .. 'x' .. GRID.h
        else
            cell[dim] = GRID[dim]
            cell[dim == 'w' and 'x' or 'y'] = 0
        end

        hs.grid.set(win, cell, screen)
    end
end

function move(direction)
    local win = hs.window.focusedWindow()
    local f = win:frame()

    if (direction == 't') then
        f.y = f.y - 10
    elseif (direction == 'r') then
        f.x = f.x + 10
    elseif (direction == 'b') then
        f.y = f.y + 10
    elseif (direction == 'l') then
        f.x = f.x - 10
    end

    win:setFrame(f)
end

function isInScreen(screen, win)
    return win:screen() == screen
end

function focusScreen(screen)
    local windows = hs.fnutils.filter(
        hs.window.orderedWindows(),
        hs.fnutils.partial(isInScreen, screen)
    )
    local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
    windowToFocus:focus()

    -- Move mouse to center of screen
    local pt = geometry.rectMidPoint(screen:fullFrame())
    mouse.setAbsolutePosition(pt)
end

windowModal:bind('', 'escape', function() windowModal:exit() end)
windowModal:bind('', 'Q', function() windowModal:exit() end)
windowModal:bind('', 'tab', function() showAvailableHotkey() end)

windowModal:bind('', 'J', 'Downhalf of Screen', function ()
    pressed.down = true
    if pressed.up then
        fullDimension('h')
    else
        nextStep('h', true, function(cell, nextSize)
            cell.y = GRID.h - GRID.h / nextSize
            cell.h = GRID.h / nextSize
        end)
    end
end, function ()
    pressed.down = false
end)

windowModal:bind('', 'L', 'Righthalf of Screen', function ()
    pressed.right = true
    if pressed.left then
        fullDimension('w')
    else
        nextStep('w', true, function(cell, nextSize)
            cell.x = GRID.w - GRID.w / nextSize
            cell.w = GRID.w / nextSize
        end)
    end
end, function ()
    pressed.right = false
end)

windowModal:bind('', 'H', 'Lefthalf of Screen', function ()
    pressed.left = true
    if pressed.right then
        fullDimension('w')
    else
        nextStep('w', false, function(cell, nextSize)
            cell.x = 0
            cell.w = GRID.w / nextSize
        end)
    end
end, function ()
    pressed.left = false
end)

windowModal:bind('', 'K', 'Uphalf of Screen', function ()
    pressed.up = true
    if pressed.down then
        fullDimension('h')
    else
        nextStep('h', false, function(cell, nextSize)
            cell.y = 0
            cell.h = GRID.h / nextSize
        end)
    end
end, function ()
    pressed.up = false
end)

windowModal:bind('', 'F', 'Fullscreen', function ()
    nextFullScreenStep()
end)

windowModal:bind('', 'I', 'Get Info', function ()
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)
    hs.alert.show(cell)
end)

windowModal:bind('shift', 'Y', 'Move NorthWest', function ()
    move('t')
    move('l')
end)

windowModal:bind('shift', 'K', 'Move Move Upward', function ()
    move('t')
end)

windowModal:bind('shift', 'U', 'Move NorthEast', function ()
    move('t')
    move('r')
end)

windowModal:bind('shift', 'H', 'Move Leftward', function ()
    move('l')
end)

windowModal:bind('shift', 'L', 'Move Rightward', function ()
    move('r')
end)

windowModal:bind('shift', 'B', 'Move SouthWest', function ()
    move('b')
    move('l')
end)

windowModal:bind('shift', 'J', 'Move Downward', function ()
    move('b')
end)

windowModal:bind('shift', 'N', 'Move SouthEast', function ()
    move('b')
    move('r')
end)

windowModal:bind('', 'N', 'Focus to next display', function ()
    focusScreen(hs.window.focusedWindow():screen():next())
end)

windowModal:bind('', 'P', 'Focus to previous display', function ()
    focusScreen(hs.window.focusedWindow():screen():previous())
end)

