ESX                           = nil
local PlayerData              = {}
local Busy, Nearby  	      = false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlPressed(2, 197) and GetLastInputMethod(2) and Busy == false and PlayerData.job.name ~= nil and PlayerData.job.name == "mechanic" then
                TriggerServerEvent("esx_mechanicradio:playSoundWithinDistanceServer", 10, "copradio", 0.6) 
                TriggerServerEvent("esx_mechanicradio:startActionB") -- Aktion für andere Personen starten
                DisableActions(GetPlayerPed(-1))
                TriggerEvent("esx_mechanicradio:startAnim", source)
                Busy = true
            -- Aktiviere esx_mechanicradio Talkie
        elseif not IsControlPressed(2, 197) and GetLastInputMethod(2) and Busy == true and PlayerData.job.name ~= nil and PlayerData.job.name == "mechanic" then
            -- Deaktiviere esx_mechanicradio Talkie
                TriggerServerEvent("esx_mechanicradio:stopActionB") -- Aktion für andere Personen stoppen
                EnableActions(GetPlayerPed(-1))
                TriggerEvent("esx_mechanicradio:stopAnim", source)
                Busy = false
            else
        end
    end
end)

-- FUNCTIONS

function EnableActions(ped)
	EnableControlAction(1, 140, true)
	EnableControlAction(1, 141, true)
	EnableControlAction(1, 142, true)
	EnableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, false) -- Disable weapon firing
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

-- EVENTS

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    Citizen.Wait(5000)
end)

RegisterNetEvent("esx_mechanicradio:startActionB") -- Aktion Person B
AddEventHandler("esx_mechanicradio:startActionB", function()
    NetworkSetTalkerProximity(0.00) -- Sprachreichweite wird unbegrenzt
end)

RegisterNetEvent("esx_mechanicradio:stopActionB") -- Aktion Person B
AddEventHandler("esx_mechanicradio:stopActionB", function()
    NetworkSetTalkerProximity(6.00) -- Sprachreichweite wird 6 Meter
end)

RegisterNetEvent("esx_mechanicradio:startAnim") -- Event, um andere Personen Animation starten zu lassen
AddEventHandler("esx_mechanicradio:startAnim", function(player)
    Citizen.CreateThread(function()
    	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        RequestAnimDict("random@arrests")
        while not HasAnimDictLoaded( "random@arrests") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(GetPlayerPed(-1), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
    end
    end)
end)
RegisterNetEvent("esx_mechanicradio:stopAnim")
AddEventHandler("esx_mechanicradio:stopAnim", function(player)
    Citizen.CreateThread(function()
        Citizen.Wait(1)
        ClearPedTasks(GetPlayerPed(-1))
    end)
end)

RegisterNetEvent('esx_mechanicradio:playSoundWithinDistanceClient')
AddEventHandler('esx_mechanicradio:playSoundWithinDistanceClient', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)
