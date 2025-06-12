Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        local streetHash1, streetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName1 = GetStreetNameFromHashKey(streetHash1)
        local streetName2 = GetStreetNameFromHashKey(streetHash2)

        local displayText = streetName1 or "Unknown"
        if streetName2 and streetName2 ~= "" then
            displayText = displayText .. " & " .. streetName2
        end

        print("[StreetNames] " .. displayText)
    end
end)
