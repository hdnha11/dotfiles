function isInScreen(screen, win)
    return win:screen() == screen
end

function focusScreen(screen)
    local windows = hs.fnutils.filter(
        hs.window.orderedWindows(),
        hs.fnutils.partial(isInScreen, screen))
    local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
    windowToFocus:focus()

    -- Move mouse to center of screen
    local pt = geometry.rectMidPoint(screen:fullFrame())
    mouse.setAbsolutePosition(pt)
end

--Bring focus to next display/screen
hs.hotkey.bind(leader, 'right', function ()
    focusScreen(hs.window.focusedWindow():screen():next())
end)

--Bring focus to previous display/screen
hs.hotkey.bind(leader, 'left', function ()
    focusScreen(hs.window.focusedWindow():screen():previous())
end)
