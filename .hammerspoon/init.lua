hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

-- Colors
blue = hs.drawing.color.blue
dodgerblue = hs.drawing.color.x11.dodgerblue
darkblue = {red = 24 / 255, blue = 195 / 255, green = 145 / 255, alpha = 1}

hotkeyTipsBackground = 'dark'

-- Key Bindings
modalManagerKeys = {{'cmd', 'shift', 'ctrl'}, 'Q'}
appModalKeys = {'alt', 'A'}
windowModalKeys = {'alt', 'W'}
toggleConsoleKeys = {'alt', 'Z'}
windowHintsKeys = {'alt', 'tab'}

modalList = {}
activeModals = {}

require('watcher')
require('window')
require('app')

if #modalList > 0 then require('modalManager') end

function showAvailableHotkey()
    if not hotkeyText then
        local hotkeyList = hs.hotkey.getHotkeys()
        local mainScreen = hs.screen.mainScreen()
        local mainResolution = mainScreen:fullFrame()
        local localMainResolution = mainScreen:absoluteToLocal(mainResolution)
        local hotkeyBackgroundRect = hs.geometry.rect(mainScreen:localToAbsolute(
            localMainResolution.w / 5,
            localMainResolution.h / 5,
            localMainResolution.w / 5 * 3,
            localMainResolution.h / 5 * 3
        ))
        hotkeyBackground = hs.drawing.rectangle(hotkeyBackgroundRect)

        if not hotkeyTipsBackground then hotkeyTipsBackground = 'light' end

        if hotkeyTipsBackground == 'light' then
            hotkeyBackground:setFillColor({red = 238 / 255, blue = 238 / 255, green = 238 / 255, alpha = 0.95})
        elseif hotkeyTipsBackground == 'dark' then
            hotkeyBackground:setFillColor({red = 40 / 255, blue = 52 / 255, green = 44 / 255, alpha = 0.95})
        end

        hotkeyBackground:setRoundedRectRadii(10, 10)
        hotkeyBackground:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeyBackground:behavior(hs.drawing.windowBehaviors.stationary)

        local hotkeyTextRect = hs.geometry.rect(
            hotkeyBackgroundRect.x + 40,
            hotkeyBackgroundRect.y + 30,
            hotkeyBackgroundRect.w - 80,
            hotkeyBackgroundRect.h - 60
        )

        hotkeyText = hs.drawing.text(hotkeyTextRect, '')
        hotkeyText:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeyText:behavior(hs.drawing.windowBehaviors.stationary)
        hotkeyText:setClickCallback(nil, function ()
            hotkeyText:delete()
            hotkeyText = nil
            hotkeyBackground:delete()
            hotkeyBackground = nil
        end)

        hotkeyFiltered = {}
        for i = 1, #hotkeyList do
            if hotkeyList[i].idx ~= hotkeyList[i].msg then
                table.insert(hotkeyFiltered, hotkeyList[i])
            end
        end

        local availableLength = 70
        local hotkeyString = ''

        for i = 2, #hotkeyFiltered, 2 do
            local tmpstr = hotkeyFiltered[i - 1].msg .. hotkeyFiltered[i].msg
            if string.len(tmpstr)<= availableLength then
                local tofilllen = availableLength - string.len(hotkeyFiltered[i - 1].msg)
                hotkeyString = hotkeyString .. hotkeyFiltered[i - 1].msg .. string.format('%'..tofilllen..'s',hotkeyFiltered[i].msg) .. '\n'
            else
                hotkeyString = hotkeyString .. hotkeyFiltered[i - 1].msg .. '\n' .. hotkeyFiltered[i].msg .. '\n'
            end
        end

        if math.fmod(#hotkeyFiltered, 2) == 1 then
            hotkeyString = hotkeyString .. hotkeyFiltered[#hotkeyFiltered].msg
        end

        local hotkeyStringStyled = hs.styledtext.new(hotkeyString, {
            font = {name = 'Courier-Bold', size = 20},
            color = dodgerblue,
            paragraphStyle = {lineSpacing = 12.0, lineBreak = 'truncateMiddle'},
            shadow = {offset = {h = 0, w = 0}, blurRadius = 0.5, color = darkblue}
        })

        hotkeyText:setStyledText(hotkeyStringStyled)
        hotkeyBackground:show()
        hotkeyText:show()
    else
        hotkeyText:delete()
        hotkeyText = nil
        hotkeyBackground:delete()
        hotkeyBackground = nil
    end
end

function exitOthers(excepts)
    function isInExcepts(value, tbl)
        for i = 1, #tbl do
            if tbl[i] == value then
                return true
            end
        end

        return false
    end

    if excepts == nil then excepts = {} end

    for i = 1, #activeModals do
        if not isInExcepts(activeModals[i].id, excepts) then
            activeModals[i].modal:exit()
        end
    end
end
