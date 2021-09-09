RegisterNetEvent('AB3:ClientBeep', function()
    TriggerClientEvent('AB3:ServerBeep', -1, source)
end)