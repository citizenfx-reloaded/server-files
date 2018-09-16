local isInVehicle = false
local currentVehicle = 0
local currentSeat = 0

CreateThread(function()
	while true do
		Wait(0)

		if not isInVehicle and not IsPlayerDead(GetPlayerId()) then
			if IsCharInAnyCar(GetPlayerPed()) then
				isInVehicle = true
				currentVehicle = GetCarCharIsUsing(GetPlayerPed(), _i)
				currentSeat = GetPedVehicleSeat(GetPlayerPed())
				TriggerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetCarModel(currentVehicle, _i)))
				TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetCarModel(currentVehicle, _i)))
			end
		elseif isInVehicle then
			if not IsCharInAnyCar(GetPlayerPed()) or IsPlayerDead(GetPlayerId()) then
				TriggerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetCarModel(currentVehicle, _i)))
				TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetCarModel(currentVehicle, _i)))
				isInVehicle = false
				currentVehicle = 0
				currentSeat = 0
			end
		end

		Wait(50)
	end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetCarCharIsUsing(ped, _i)
    for i=-2,GetMaximumNumberOfPassengers(vehicle, _i) do
        if(GetCharInCarPassengerSeat(vehicle, i, _i) == ped) then return i end
    end
    return -2
end