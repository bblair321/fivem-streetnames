Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Street names
        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName1 = GetStreetNameFromHashKey(streetHash1) or "Unknown"
        local streetName2 = GetStreetNameFromHashKey(streetHash2) or ""

        local streetDisplay = streetName1
        if streetName2 ~= "" then
            streetDisplay = streetDisplay .. " & " .. streetName2
        end

        -- Zone name
        local zoneCode = GetNameOfZone(coords.x, coords.y, coords.z)
        local zoneName = GetLabelText(zoneCode) or "Unknown Zone"

        -- Settings
        local baseX = 0.015
        local baseY = 0.89
        local lineHeight = 0.03
        local boxWidth = 0.36
        local boxHeight = 0.075

        -- Colors
        local bgColor = { r = 5, g = 15, b = 30, a = 220 } -- dark blue
        local labelColor = { r = 100, g = 180, b = 255, a = 255 } -- bluish text
        local valueColor = { r = 255, g = 255, b = 255, a = 255 } -- white

        -- Draw background box
        DrawRect(baseX + (boxWidth / 2), baseY + (boxHeight / 2), boxWidth, boxHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)

        -- Function to draw labeled lines
        local function drawLabeledLine(label, value, yOffset)
            local labelX = baseX + 0.005
            local valueX = baseX + 0.09
            local y = baseY + yOffset

            SetTextFont(0)
            SetTextScale(0.35, 0.35)
            SetTextColour(labelColor.r, labelColor.g, labelColor.b, labelColor.a)
            SetTextEntry("STRING")
            AddTextComponentString(label)
            DrawText(labelX, y)

            SetTextFont(4)
            SetTextScale(0.38, 0.38)
            SetTextColour(valueColor.r, valueColor.g, valueColor.b, valueColor.a)
            SetTextEntry("STRING")
            AddTextComponentString(value)
            DrawText(valueX, y)
        end

        -- Draw lines
        drawLabeledLine("STREET:", streetDisplay, 0.005)
        drawLabeledLine("ZONE:", zoneName, 0.035)
    end
end)
