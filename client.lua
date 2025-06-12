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
        local textColor = { r = 255, g = 255, b = 255 }         -- white
        local boxColor = { r = 10, g = 20, b = 50, a = 200 }    -- navy blue

        -- Auto-size box width based on longest line
        local longestLine = (#streetDisplay > #zoneName) and streetDisplay or zoneName
        local charWidth = 0.006
        local padding = 0.015
        local rectWidth = padding + (string.len(longestLine) * charWidth)

        -- Position
        local rectX = 0.5
        local rectY = 0.04       -- Top-center
        local rectHeight = 0.065 -- Taller box to fit 2 lines

        -- Draw background box
        DrawRect(rectX, rectY, rectWidth, rectHeight, boxColor.r, boxColor.g, boxColor.b, boxColor.a)

        -- Draw street text (top line)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.5, 0.5)
        SetTextColour(textColor.r, textColor.g, textColor.b, 255)
        SetTextCentre(true)
        SetTextDropshadow(1, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(streetDisplay)
        DrawText(rectX, rectY - 0.018)  -- top line inside box

        -- Draw zone text (bottom line)
        SetTextFont(0)
        SetTextScale(0.4, 0.4)
        SetTextEntry("STRING")
        AddTextComponentString(zoneName)
        DrawText(rectX, rectY + 0.005)  -- lower inside box
    end
end)
