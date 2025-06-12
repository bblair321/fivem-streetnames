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
        local boxHeight = 0.08 -- tighter height
        local boxCenterX = 0.5
        local boxCenterY = boxHeight / 2 + 0.003 -- flush to top with slight spacing

        -- Colors
        local bgColor = { r = 5, g = 15, b = 30, a = 220 }
        local labelColor = { r = 100, g = 180, b = 255, a = 255 }
        local valueColor = { r = 255, g = 255, b = 255, a = 255 }

        -- Draw background box
        DrawRect(boxCenterX, boxCenterY, boxWidth, boxHeight, bgColor.r, bgColor.g, bgColor.b, bgColor.a)

        -- Helper
        local function drawText(x, y, text, font, scale, color, center)
            SetTextFont(font)
            SetTextScale(scale, scale)
            SetTextColour(color.r, color.g, color.b, color.a)
            if center then SetTextCentre(true) end
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(x, y)
        end

        -- Clock (centered top line)
        drawText(boxCenterX, boxCenterY - 0.030, topLine, 4, 0.42, valueColor, true)

        -- STREET
        drawText(boxCenterX - 0.1, boxCenterY - 0.005, "STREET:", 0, 0.30, labelColor, false)
        drawText(boxCenterX - 0.03, boxCenterY - 0.005, streetDisplay, 4, 0.30, valueColor, false)

        -- ZONE
        drawText(boxCenterX - 0.1, boxCenterY + 0.020, "ZONE:", 0, 0.30, labelColor, false)
        drawText(boxCenterX - 0.03, boxCenterY + 0.020, zoneName, 4, 0.30, valueColor, false)

        -- Optional: draw a thin white border line at the bottom of box
        DrawRect(boxCenterX, boxCenterY + (boxHeight / 2), boxWidth, 0.001, 255, 255, 255, 100)
    end
end)
