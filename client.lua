Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        -- Get street hashes
        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        
        -- Convert hashes to street names
        local streetName1 = GetStreetNameFromHashKey(streetHash1)
        local streetName2 = GetStreetNameFromHashKey(streetHash2)

        local displayText = streetName1
        if streetName2 ~= nil and streetName2 ~= "" then
            displayText = displayText .. " & " .. streetName2
        end

        -- Text display settings
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.5, 0.5)
        SetTextColour(255, 255, 255, 255) -- White color
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(displayText)
        DrawText(0.5 - (string.len(displayText) * 0.0035), 0.03)  -- Center top, adjusted by text length
    end
end)
