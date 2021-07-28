RegisterServerEvent('tackle_tackle')
AddEventHandler('tackle_tackle', function(player)
    TriggerClientEvent("tackle_tackleragdoll", player)
end)