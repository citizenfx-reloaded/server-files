CreateThread(function()
    local isDead = false
    local hasBeenDead = false

    while true do
        Wait(0)

        local player = GetPlayerId()

        if player.isActive then
            local ped = player.ped

            if ped.isFatallyInjured and not isDead then
                isDead = true

                local killer = player.lastKiller
                local killerinvehicle = false
                local killervehiclename = ''
                local killervehicleseat = 0

                if(killer ~= nil and killer.isActive) then
                    if IsCharInAnyCar(killer.ped) then
                        killerinvehicle = true
                        killervehiclename = GetDisplayNameFromVehicleModel(GetCarModel(GetCarCharIsUsing(killer.ped, _i), _i))
                        killervehicleseat = GetPedVehicleSeat(killer.ped)
                    else killerinvehicle = false
                    end
                else killer = -1
                end

                local killer = player.lastKiller

                local networkId = ped.networkId
                local deathReason = GetDestroyerOfNetworkId(networkId)

                if killer == player or killer == -1 then
                    TriggerEvent('baseevents:onPlayerDied', player.serverId, ped.position)
                    TriggerServerEvent('baseevents:onPlayerDied', player.serverId, ped.position)
                    hasBeenDead = true
                else
                    TriggerEvent('baseevents:onPlayerKilled', player.serverId, {killer=killer.serverId, reason=deathReason, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=ped.position})
                    TriggerServerEvent('baseevents:onPlayerKilled', player.serverId, {killer=killer.serverId, reason=deathReason, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=ped.position})
                    hasBeenDead = true
                end
            elseif not ped.isFatallyInjured then
                isDead = false
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and HowLongHasNetworkPlayerBeenDeadFor(player, _r) > 0 then
                TriggerEvent('baseevents:onPlayerWasted', player.serverId, ped.position)
                TriggerServerEvent('baseevents:onPlayerWasted', player.serverId, ped.position)

                hasBeenDead = true
            elseif hasBeenDead and HowLongHasNetworkPlayerBeenDeadFor(player, _r) <= 0 then
                hasBeenDead = false
            end
        end
    end
end)
