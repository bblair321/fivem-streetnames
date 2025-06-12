Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName1 = GetStreetNameFromHashKey(streetHash1) or "Unknown"
        local streetName2 = GetStreetNameFromHashKey(streetHash2) or ""

        local displayText = streetName1
        if streetName2 ~= "" then
            displayText = displayText .. " & " .. streetName2
        end

        -- Draw background rectangle (black, semi-transparent)
        local rectX = 0.5
        local rectY = 0.03
        local rectWidth = 0.3
        local rectHeight = 0.03
        DrawRect(rectX, rectY, rectWidth, rectHeight, 0, 0, 0, 150)

        -- Draw the street name text (yellow)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.6, 0.6)
        SetTextColour(255, 255, 0, 255) -- bright yellow
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(displayText)
        -- Center the text horizontally at 0.5, vertically at rectY - half rect height
        DrawText(rectX - (string.len(displayText) * 0.0035), rectY - (rectHeight / 2) + 0.005)
    end
end)
