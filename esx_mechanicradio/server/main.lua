ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("esx_mechanicradio:startActionB")
AddEventHandler("esx_mechanicradio:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "mechanic" then
			--	TriggerClientEvent("esx_mechanicradio:startAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_mechanicradio:startActionB", xPlayer.source) -- Client Event auf Aktionen start
				
			end
		end
end)

RegisterNetEvent("esx_mechanicradio:stopActionB")
AddEventHandler("esx_mechanicradio:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "mechanic" then
				TriggerClientEvent("esx_mechanicradio:stopAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_mechanicradio:stopActionB", xPlayer.source) -- Client Event auf Aktionen start

			end
		end
end)

RegisterServerEvent('esx_mechanicradio:playSoundWithinDistanceServer')
AddEventHandler('esx_mechanicradio:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "mechanic" then
				TriggerClientEvent('esx_mechanicradio:playSoundWithinDistanceClient', -1, xPlayer.source, maxDistance, soundFile, soundVolume)
			end
		end
end)
