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

        -- HUD position
        local rectX = 0.5
        local rectY = 0.03
        local rectWidth = 0.3
        local rectHeight = 0.035

        -- Draw black background rectangle
        DrawRect(rectX, rectY, rectWidth, rectHeight, 0, 0, 0, 150)

        -- Draw centered yellow text
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.6, 0.6)
        SetTextColour(255, 255, 0, 255) -- yellow
        SetTextCentre(true) -- ← this is the key for perfect centering
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(displayText)
        DrawText(rectX, rectY - 0.0125)
    end
end)
