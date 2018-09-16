RegisterServerEvent('onPlayerDied')
AddEventHandler('onPlayerDied', function(player, reason)
    print('[DEAD] player ' .. GetPlayerName(player) .. ' died with reason ' .. tostring(reason))

    TriggerClientEvent('onPlayerDied', -1, player, reason)
end)

RegisterServerEvent('onPlayerKilled')
AddEventHandler('onPlayerKilled', function(player, attacker, reason)
    print('[DEAD] player ' .. GetPlayerName(player) .. ' got killed by ' .. GetPlayerName(attacker) .. ' with reason ' .. tostring(reason))

    TriggerClientEvent('onPlayerKilled', -1, player, attacker, reason)
end)

RegisterServerEvent('onPlayerWasted')
AddEventHandler('onPlayerWasted', function(player)
    TriggerClientEvent('onPlayerWasted', -1, source)
end)

RegisterServerEvent('playerJoining')
AddEventHandler('playerJoining', function()
    TriggerClientEvent('playerJoining', -1, source)
end)

RegisterServerEvent('sessionInitialized')
AddEventHandler('sessionInitialized', function()
	
end)

AddEventHandler('playerActivated', function()
    print('[Join] ' .. GetPlayerName(source) .. ' (' .. source .. ') has joined the game.')
end)

RegisterServerEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    print('[Spawn] ' .. GetPlayerName(source) .. ' spawned.')
end)
