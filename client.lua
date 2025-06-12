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

        -- Style colors
        local textColor = { r = 255, g = 255, b = 255 }
        local boxColor = { r = 10, g = 20, b = 50, a = 200 }

        -- Determine the longest line
        local longestLine = (#streetDisplay > #zoneName) and streetDisplay or zoneName
        local charWidth = 0.006
        local padding = 0.015
        local rectWidth = padding + (string.len(longestLine) * charWidth)

        -- Box position and size
        local rectX = 0.5
        local rectY = 0.04
        local rectHeight = 0.065

        -- Draw background
        DrawRect(rectX, rectY, rectWidth, rectHeight, boxColor.r, boxColor.g, boxColor.b, boxColor.a)

        -- Text settings shared for both lines
        local function drawCenteredText(text, x, y, scale)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(scale, scale)
            SetTextColour(textColor.r, textColor.g, textColor.b, 255)
            SetTextCentre(true)
            SetTextDropshadow(1, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(x, y)
        end

        -- Draw street name (top)
        drawCenteredText(streetDisplay, rectX, rectY - 0.018, 0.5)

        -- Draw zone name (bottom)
        drawCenteredText(zoneName, rectX, rectY + 0.005, 0.5)
    end
end)
