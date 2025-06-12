Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Get street names
        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName1 = GetStreetNameFromHashKey(streetHash1) or "Unknown"
        local streetName2 = GetStreetNameFromHashKey(streetHash2) or ""

        local streetDisplay = streetName1
        if streetName2 ~= "" then
            streetDisplay = streetDisplay .. " & " .. streetName2
        end

        -- Get zone name
        local zoneCode = GetNameOfZone(coords.x, coords.y, coords.z)
        local zoneName = GetLabelText(zoneCode) or "Unknown Zone"

        -- Get in-game time
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        local timeStr = string.format("%02d:%02d", hour, minute)

        -- HUD Box settings
        local boxCenterX = 0.5
        local boxCenterY = 0.925
        local boxWidth = 0.24
        local boxHeight = 0.09

        -- Colors
        local bgColor = { r = 5, g = 15, b = 30, a = 200 }
        local labelColor = { r = 100, g = 180, b = 255, a = 255 }
        local valueColor = { r = 255, g = 255, b = 255, a = 255 }

        -- Draw background
        DrawRect(boxCenterX, boxCenterY, boxWidth, boxHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)

        -- Text drawing helper
        local function drawText(x, y, text, font, scale, color, center)
            SetTextFont(font)
            SetTextScale(scale, scale)
            SetTextColour(color.r, color.g, color.b, color.a)
            if center then SetTextCentre(true) end
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(x, y)
        end

        -- Draw clock (centered top)
        drawText(boxCenterX, boxCenterY - 0.037, timeStr, 4, 0.4, valueColor, true)

        -- Draw STREET label and value
        drawText(boxCenterX - 0.1, boxCenterY - 0.007, "STREET:", 0, 0.3, labelColor, false)
        drawText(boxCenterX - 0.03, boxCenterY - 0.007, streetDisplay, 4, 0.32, valueColor, false)

        -- Draw ZONE label and value
        drawText(boxCenterX - 0.1, boxCenterY + 0.022, "ZONE:  ", 0, 0.3, labelColor, false)
        drawText(boxCenterX - 0.03, boxCenterY + 0.022, zoneName, 4, 0.32, valueColor, false)
    end
end)
