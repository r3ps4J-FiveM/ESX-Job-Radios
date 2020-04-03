ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("esx_ambulanceradio:startActionB")
AddEventHandler("esx_ambulanceradio:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" then
			--	TriggerClientEvent("esx_ambulanceradio:startAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_ambulanceradio:startActionB", xPlayer.source) -- Client Event auf Aktionen start
				
			end
		end
end)

RegisterNetEvent("esx_ambulanceradio:stopActionB")
AddEventHandler("esx_ambulanceradio:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" then
				TriggerClientEvent("esx_ambulanceradio:stopAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_ambulanceradio:stopActionB", xPlayer.source) -- Client Event auf Aktionen start

			end
		end
end)

RegisterServerEvent('esx_ambulanceradio:playSoundWithinDistanceServer')
AddEventHandler('esx_ambulanceradio:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "ambulance" then
				TriggerClientEvent('esx_ambulanceradio:playSoundWithinDistanceClient', -1, xPlayer.source, maxDistance, soundFile, soundVolume)
			end
		end
end)
