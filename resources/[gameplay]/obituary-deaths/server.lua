AddEventHandler('baseevents:onPlayerDied', function(player, position)
    TriggerClientEvent('obituaryDied', -1, player)
end)

AddEventHandler('baseevents:onPlayerKilled', function(player, data)
    TriggerClientEvent('obituaryKilled', -1, player, data.killer, data.reason)
end)