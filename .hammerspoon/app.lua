appModal = hs.hotkey.modal.new()
local modalPackage = {}
modalPackage.id = 'appModal'
modalPackage.modal = appModal
table.insert(modalList, modalPackage)

local appList = {
    {shortcut = 'I', name = 'iTerm'},
    {shortcut = 'C', name = 'Google Chrome'},
    {shortcut = 'O', name = 'Opera'},
    {shortcut = 'X', name = 'FireFox'},
    {shortcut = 'R', name = 'Safari'},
    {shortcut = 'M', name = 'Mail'},
    {shortcut = 'F', name = 'Finder'},
    {shortcut = 'N', name = 'Notes'},
    {shortcut = 'E', name = 'Enpass'},
    {shortcut = 'D', name = 'Sequel Pro'},
    {shortcut = 'K', name = 'Sketch'},
    {shortcut = 'S', name = 'Slack'},
    {shortcut = 'Y', name = 'Skype'},
    {shortcut = 'V', name = 'Viber'},
    {shortcut = 'B', name = 'iBooks'},
    {shortcut = 'T', name = 'iTunes'},
    {shortcut = 'A', name = 'Atom'},
}

function appModal:entered()
    for i = 1, #modalList do
        if modalList[i].id == 'appModal' then
            table.insert(activeModals, modalList[i])
        end
    end

    if hotkeyText then
        hotkeyText:delete()
        hotkeyText = nil
        hotkeyBackground:delete()
        hotkeyBackground = nil
    end

    if showAppLauncherTips == nil then showAppLauncherTips = true end
    if showAppLauncherTips == true then showAvailableHotkey() end
end

function appModal:exited()
    for i = 1, #activeModals do
        if activeModals[i].id == 'appModal' then
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

appModal:bind('', 'escape', function () appModal:exit() end)
appModal:bind('', 'Q', function () appModal:exit() end)
appModal:bind('', 'tab', function () showAvailableHotkey() end)

for i = 1, #appList do
    appModal:bind('', appList[i].shortcut, appList[i].name, function ()
        hs.application.launchOrFocus(appList[i].name)
        appModal:exit()

        if hotkeyText then
            hotkeyText:delete()
            hotkeyText = nil
            hotkeyBackground:delete()
            hotkeyBackground = nil
        end
    end)
end
