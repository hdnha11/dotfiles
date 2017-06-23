applist = {
    {shortcut = 'i', appname = 'iTerm'},
    {shortcut = 'a', appname = 'Atom'},
    {shortcut = 'g', appname = 'Google Chrome'},
    {shortcut = 's', appname = 'Slack'},
}

for i = 1, #applist do
    hs.hotkey.bind(leader, applist[i].shortcut, function ()
        hs.application.launchOrFocus(applist[i].appname)
    end)
end

hs.hotkey.bind({'alt'}, 'tab', function ()
    hs.hints.windowHints()
end)
