local showHintMode = {'alt'}
local showHintAllMode = {'alt', 'shift'}
local showHintKey = 'tab'
local hintDuration = 20 --s
local maxDescriptorLength = 50
local appList = {
    {shortcut = 'I', name = 'iTerm'},
    {shortcut = 'G', name = 'Google Chrome'},
    {shortcut = 'O', name = 'Opera'},
    {shortcut = 'K', name = 'Sketch'},
    {shortcut = 'S', name = 'Slack'},
    {shortcut = 'A', name = 'Atom'},
}

function appHints()
    message = ''

    for i, app in ipairs(appList) do
        message = message .. app.shortcut .. ': ' .. app.name

        if i ~= #appList then
            message = message .. '\n'
        end
    end

    return message
end

function enterHintMode(appHinter, time)
    message = appHints()
    hs.alert.show(message, time)

    hs.timer.doAfter(time, function()
        appHinter:exit()
    end)
end

function takeHint(key, i, appHinter)
    return function()
        if appList[i] ~= nil then
            hs.application.launchOrFocus(appList[i].name)
            appHinter:exit()
        end
    end
end

function cleanUpHints()
    hs.alert.closeAll() -- this is janky, since it might conflict with other notifications
end

appHinter = hs.hotkey.modal.new(showHintMode, showHintKey)

function appHinter:entered()
    enterHintMode(appHinter, hintDuration)
end

function appHinter:exited()
    cleanUpHints()
end

appHinter:bind({}, 'escape', function()
    appHinter:exit()
end)

for i, app in ipairs(appList) do
    appHinter:bind({}, app.shortcut, takeHint(app.shortcut, i, appHinter))
end

-- Displays a keyboard hint for switching focus to each window
hs.hotkey.bind(showHintAllMode, showHintKey, function ()
     hs.hints.windowHints()
end)
