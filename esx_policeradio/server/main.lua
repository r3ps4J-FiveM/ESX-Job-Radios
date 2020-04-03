ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("esx_policeradio:startActionB")
AddEventHandler("esx_policeradio:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" then
			--	TriggerClientEvent("esx_policeradio:startAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_policeradio:startActionB", xPlayer.source) -- Client Event auf Aktionen start
				
			end
		end
end)

RegisterNetEvent("esx_policeradio:stopActionB")
AddEventHandler("esx_policeradio:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" then
				TriggerClientEvent("esx_policeradio:stopAnim", xPlayer.source) -- Client Event auf Animatonen start
				TriggerClientEvent("esx_policeradio:stopActionB", xPlayer.source) -- Client Event auf Aktionen start

			end
		end
end)

RegisterServerEvent('esx_policeradio:playSoundWithinDistanceServer')
AddEventHandler('esx_policeradio:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" then
				TriggerClientEvent('esx_policeradio:playSoundWithinDistanceClient', -1, xPlayer.source, maxDistance, soundFile, soundVolume)
			end
		end
end)
