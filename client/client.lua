--------------------------------------------------
------------- JOIN OUR DISCORD SERVER ------------
--------- https://discord.gg/7gbCD9Fzct ----------
--------------------------------------------------
--------------- DEVELOPED BY FLAP ----------------
-------------------- WITH 💜 ---------------------
--------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()
local lastJob = nil
local PlayerData = nil
local CanSendWebhook = true

Citizen.CreateThread(function()
  while ESX == nil do	

    Citizen.Wait(10)
  end
  
  Citizen.Wait(3000)
  if PlayerData == nil or PlayerData.job == nil then
	  	PlayerData = ESX.GetPlayerData()
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('flap_hud:retrieveData')
AddEventHandler('flap_hud:retrieveData', function(data)
	local jobName = PlayerData.job.label
	local gradeName = PlayerData.job.grade_label

	SendNUIMessage({
		action = 'YRPmoney',
		cash = data.cash,
		bank = data.bank,
		black_money = data.black_money,
		society = data.society,
		frakcnikasa = data.frakcnikasa,
		datumnarozeni = data.datumnarozeni
	})
	SendNUIMessage({
		action = 'YRPcharacterName',
		charactername = data.charactername
	})
	SendNUIMessage({
		action = 'YRPjob',
		data = jobName
	})
	SendNUIMessage({
		action = 'YRPjobGrade',
		data = gradeName
	})
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('flap_hud:retrieveData')

		if CanSendWebhook then
			TriggerServerEvent('flap_hud:SendDiscordWebhook') 
			CanSendWebhook = false
		end
	end
end)

local armor
local health
local HunVal = 0
local ThiVal = 0

Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(1000)
		armor = GetPedArmour(GetPlayerPed(-1))
		health = (GetEntityHealth(GetPlayerPed(-1))-100)

		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			HunVal = status.val/1000000*100
		end)
		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			ThiVal = status.val/1000000*100
		end)
    end
end)


Citizen.CreateThread(function()
 while true do
		Citizen.Wait(200)
		
		SendNUIMessage({
			action = 'YRPstatus',
			health = health,
			armor = armor,
			hunger =  HunVal,
			thirst =  ThiVal,
		})
	end
end)

local isMenuPaused = false

function menuPaused()
	SendNUIMessage({
		action = 'YRPpausemenu',
		data = isMenuPaused
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPauseMenuActive() then
			if not isMenuPaused then
				isMenuPaused = true
				menuPaused()
			end
		elseif isMenuPaused then
			isMenuPaused = false
			menuPaused()
		end
		if IsControlJustPressed(1, Config.general_config_settings.SlideHUD) then
			SendNUIMessage({
				action = 'YRPslide'
			})
		end
	end
end)