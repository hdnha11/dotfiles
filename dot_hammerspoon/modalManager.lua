modalManagerKeys = modalManagerKeys or {{'cmd', 'shift', 'ctrl'}, 'Q'}
modalManager = hs.hotkey.modal.new(modalManagerKeys[1], modalManagerKeys[2], 'Toggle Modal Supervisor')
modalManager:bind(modalManagerKeys[1], modalManagerKeys[2], 'Toggle Modal Supervisor', function ()
    modalManager:exit()
end)

function modalManager:exited()
    exitOthers()
    if hotkeyText then
        hotkeyText:delete()
        hotkeyText = nil
        hotkeyBackground:delete()
        hotkeyBackground = nil
    end
end

if appModal then
    appModalKeys = appModalKeys or {'alt', 'A'}
    if string.len(appModalKeys[2]) > 0 then
        modalManager:bind(appModalKeys[1], appModalKeys[2], 'Enter Application Mode', function ()
            exitOthers()
            appModal:enter()
        end)
    end
end

if windowModal then
    windowModalKeys = windowModalKeys or {'alt', 'W'}
    if string.len(windowModalKeys[2]) > 0 then
        modalManager:bind(windowModalKeys[1], windowModalKeys[2], 'Enter Window Mode', function ()
            exitOthers()
            windowModal:enter()
        end)
    end
end

toggleConsoleKeys = toggleConsoleKeys or {'alt', 'Z'}
if string.len(toggleConsoleKeys[2]) > 0 then
    modalManager:bind(toggleConsoleKeys[1], toggleConsoleKeys[2], 'Toggle Hammerspoon Console', function ()
        hs.toggleConsole()
    end)
end

windowHintsKeys = windowHintsKeys or {'alt', 'tab'}
if string.len(windowHintsKeys[2]) > 0 then
    modalManager:bind(windowHintsKeys[1], windowHintsKeys[2], 'Show Windows Hint', function ()
        exitOthers()
        hs.hints.windowHints()
    end)
end

if modalManager then
    if launchModalManager == nil then launchModalManager = true end
    if launchModalManager == true then modalManager:enter() end
end
