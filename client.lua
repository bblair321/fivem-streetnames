Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Street + Zone
        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName1 = GetStreetNameFromHashKey(streetHash1) or "Unknown"
        local streetName2 = GetStreetNameFromHashKey(streetHash2) or ""
        local streetDisplay = streetName1
        if streetName2 ~= "" then
            streetDisplay = streetDisplay .. " & " .. streetName2
        end

        local zoneCode = GetNameOfZone(coords.x, coords.y, coords.z)
        local zoneName = GetLabelText(zoneCode) or "Unknown"

        -- Time
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        local timeStr = string.format("%02d:%02d", hour, minute)

        -- Compass
        local heading = GetEntityHeading(playerPed)
        local function getCompassDirection(deg)
            if deg >= 337.5 or deg < 22.5 then return "N"
            elseif deg < 67.5 then return "NE"
            elseif deg < 112.5 then return "E"
            elseif deg < 157.5 then return "SE"
            elseif deg < 202.5 then return "S"
            elseif deg < 247.5 then return "SW"
            elseif deg < 292.5 then return "W"
            else return "NW" end
        end
        local compass = getCompassDirection(heading)
        local topLine = timeStr .. "   [" .. compass .. "]"

        -- Position and size
        local boxWidth = 0.26
        local boxHeight = 0.08
        local boxCenterX = 0.5
        local boxCenterY = boxHeight / 2 + 0.003

        -- Colors
        local bgColor = { r = 10, g = 15, b = 40, a = 200 }       -- dark, transparent blue
        local borderColor = { r = 40, g = 120, b = 255, a = 180 } -- electric blue border
        local labelColor = { r = 130, g = 180, b = 255, a = 255 } -- softer blue
        local valueColor = { r = 240, g = 245, b = 255, a = 255 } -- almost white

        -- Draw background with border (border behind the box)
        DrawRect(boxCenterX, boxCenterY, boxWidth + 0.006, boxHeight + 0.006, borderColor.r, borderColor.g, borderColor.b, borderColor.a)
        DrawRect(boxCenterX, boxCenterY, boxWidth, boxHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)

        -- Text drawing helper function
        local function drawText(x, y, text, font, scale, color, center, right)
            SetTextFont(font)
            SetTextScale(scale, scale)
            SetTextColour(color.r, color.g, color.b, color.a)
            SetTextCentre(center or false)
            if right then
                SetTextRightJustify(true)
                SetTextWrap(0.0, x)
            end
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(x, y)
        end

        -- Clock + compass (centered, bold font)
        drawText(boxCenterX, boxCenterY - 0.040, topLine, 4, 0.48, valueColor, true)

        -- Horizontal divider line below clock/compass
        DrawRect(boxCenterX, boxCenterY - 0.020, boxWidth * 0.9, 0.0015, borderColor.r, borderColor.g, borderColor.b, 180)

        -- Labels (right aligned)
        drawText(boxCenterX - 0.05, boxCenterY - 0.005, "STREET:", 0, 0.30, labelColor, false, true)
        drawText(boxCenterX - 0.05, boxCenterY + 0.020, "ZONE:", 0, 0.30, labelColor, false, true)

        -- Values (left aligned)
        drawText(boxCenterX - 0.03, boxCenterY - 0.005, streetDisplay, 4, 0.32, valueColor, false)
        drawText(boxCenterX - 0.03, boxCenterY + 0.020, zoneName, 4, 0.32, valueColor, false)
    end
end)
