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
        local rectY = 0.045  -- slightly lower
        local rectWidth = 0.32
        local rectHeight = 0.045

        -- Draw black background rectangle
        DrawRect(rectX, rectY, rectWidth, rectHeight, 0, 0, 0, 180)

        -- Draw centered yellow text
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.5, 0.5)
        SetTextColour(255, 255, 0, 255)
        SetTextCentre(true)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(displayText)
        DrawText(rectX, rectY - 0.012)
    end
end)
