function triggerEvent(eventName, ...)
    --TriggerEvent(eventName, ...)
    TriggerServerEvent(eventName, ...)
end

AddEventHandler('playerSpawned', function()
	TriggerServerEvent('playerSpawned')
end)