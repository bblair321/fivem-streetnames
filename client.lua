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

        -- Box position and dimensions
        local boxCenterX = 0.5
        local boxCenterY = 0.94
        local boxWidth = 0.18   -- compact width
        local boxHeight = 0.06  -- enough for two lines

        -- Colors
        local bgColor = { r = 5, g = 15, b = 30, a = 200 }
        local labelColor = { r = 100, g = 180, b = 255, a = 255 }
        local valueColor = { r = 255, g = 255, b = 255, a = 255 }

        -- Draw background box
        DrawRect(boxCenterX, boxCenterY, boxWidth, boxHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)

        -- Function to draw label + value centered inside the box
        local function drawLine(label, value, lineOffset)
            local labelX = boxCenterX - 0.075
            local valueX = boxCenterX - 0.01
            local y = boxCenterY - 0.025 + lineOffset

            -- Label
            SetTextFont(0)
            SetTextScale(0.3, 0.3)
            SetTextColour(labelColor.r, labelColor.g, labelColor.b, labelColor.a)
            SetTextEntry("STRING")
            AddTextComponentString(label)
            DrawText(labelX, y)

            -- Value
            SetTextFont(4)
            SetTextScale(0.32, 0.32)
            SetTextColour(valueColor.r, valueColor.g, valueColor.b, valueColor.a)
            SetTextEntry("STRING")
            AddTextComponentString(value)
            DrawText(valueX, y)
        end

        -- Draw both lines
        drawLine("STREET:", streetDisplay, 0.0)
        drawLine("ZONE:  ", zoneName, 0.025)
    end
end)
