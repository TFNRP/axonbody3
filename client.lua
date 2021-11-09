-- globals
local hudForceHide = false
local hudPresence
local activated = false
local disabled = false
local bodycammodel = Config.CheckModel

-- compatibility with frameworks

if GetConvar('tfnrp_framework_init') == 'true' then
  Config.CommandAccessHandling = function ()
    return exports.framework:GetLocalClientDuty() > 0
  end
end

----------------------------------------------------------
-------------------- Commands
----------------------------------------------------------


-- HUD

RegisterCommand('axonhide', function()
  hudForceHide = true
  ShowNotification("~y~Axon Body 3~s~ overlay now ~r~hidden~s~.")
end)

RegisterCommand('axonshow', function()
  hudForceHide = false
  ShowNotification("~y~Axon Body 3~s~ overlay now ~g~visible~s~.")
end)

RegisterCommand('axontoggle', function()
local ped = PlayerPedId()  
  if not CheckBodycam(ped) then
    ShowNotification("You have to wear a ~r~bodycam~s~ to turn it on/off.")
  else
if texturechangeable == 1 then
  if disabled then
  disabled = false
  SetPedComponentVariation(ped, componentID, drawableID, 0, 0)
  ShowNotification("~y~Axon Body 3 ~g~turned on~s~.")
  else
  disabled = true
  activated = false
  SetPedComponentVariation(ped, componentID, drawableID, 2, 0)
  ShowNotification("~y~Axon Body 3 ~r~turned off~s~.")
  end
  else
  ShowNotification("Your Bodycam can't be shut off.")
  end
  end
end)

-- Activation and deactivation

if Config.CommandBinding then
  RegisterKeyMapping('axon', 'Toggle Axon Body 3', 'keyboard', Config.CommandBinding)
end
RegisterCommand('axon', function ()
local ped = PlayerPedId()
  if activated then
    DeactivateAB3()
    ShowNotification("~y~Axon Body 3~s~ has ~r~stopped recording~s~.")
  else
	  if not CheckBodycam(ped) then
		ShowNotification("You have to wear a ~r~bodycam~s~ to use ~y~Axon Body 3~s~.")
	  elseif not Config:CommandAccessHandling() then
		  ShowNotification("You have to be ~r~on duty~s~ to enable ~y~Axon Body 3~s~.")
		else
			if disabled then
			ShowNotification("Your ~y~bodycam~s~ is turned ~r~off~s~.")
		else
      ActivateAB3()
      ShowNotification("~y~Axon Body 3~s~ has ~g~started recording~s~.")
	  end
    end
  end
end)

RegisterCommand('axonon', function ()
local ped = PlayerPedId()
  if not CheckBodycam(ped) then
    ShowNotification("You have to wear a ~r~bodycam~s~ to use ~y~Axon Body 3~s~.")
  elseif not Config:CommandAccessHandling() then
      ShowNotification("You have to be ~r~on duty~s~ to enable ~y~Axon Body 3~s~.")
    else
    if activated then
      ShowNotification("~y~Axon Body 3~s~ is already ~g~recording~s~.")
    else
		if disabled then
		ShowNotification("Your ~y~bodycam~s~ is turned ~r~off~s~.")
		else
      ActivateAB3()
      ShowNotification("~y~Axon Body 3~s~ has ~g~started recording~s~.")
	  end
    end
  end
end)

RegisterCommand('axonoff', function ()
  if not activated then
    ShowNotification("~y~Axon Body 3~s~ has already ~r~stopped recording~s~.")
  else
    DeactivateAB3()
    ShowNotification("~y~Axon Body 3~s~ has ~r~stopped recording~s~.")
  end
end)


----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------


-- Events

RegisterNetEvent("AB3:SetState", function(state)
  if state == true then
    ActivateAB3()
  elseif state == false then
    DeactivateAB3()
  end
end)

RegisterNetEvent("AB3:ServerBeep", function(netId)
  local otherPed = GetPlayerPed(GetPlayerFromServerId(netId))
  local ped = PlayerPedId()
  if DoesEntityExist(otherPed) and (IsPedInAnyVehicle(ped) == IsPedInAnyVehicle(otherPed)) or not IsPedInAnyVehicle(ped) then
    local volume = 0.05
    local radius = 10

    local playerCoords = GetEntityCoords(ped)
    local targetCoords = GetEntityCoords(otherPed)

    local distance = #(playerCoords - targetCoords)
    local distanceVolumeMultiplier = volume / radius
    local distanceVolume = volume - (distance * distanceVolumeMultiplier)

    if (distance <= radius) then
      SendNUIMessage({ AxonBeep = { volume = distanceVolume } })
    end
  end
end)

-- Utils

function ActivateAB3()
  if activated then
    return error("AB3 attempted to activate when already active.")
  end

  activated = true
	local ped = PlayerPedId()
	if texturechangeable > 0 then
	SetPedComponentVariation(ped, componentID, drawableID, 1, 0)
	end
  -- beeper
  Citizen.CreateThread(function()
    Citizen.Wait(12e4)
    while activated do
		if not CheckBodycam(ped) then
		DeactivateAB3()
		end
      TriggerServerEvent("AB3:ClientBeep")
      Citizen.Wait(12e4)
    end
  end)

  -- HUD
  Citizen.CreateThread(function()
    while activated do
      Citizen.Wait(0)
      if (GetFollowPedCamViewMode() == 4 or Config.ThirdPersonMode) and not hudForceHide then
        if not hudPresence then
          SetHudPresence(true)
        end
      elseif hudPresence then
        SetHudPresence(false)
      end
    end
    SetHudPresence(false)
  end)
end

function DeactivateAB3()
  if not activated then
    return error("AB3 attempted to deactivate when already deactivated.")
  end
	local ped = PlayerPedId()
	if texturechangeable > 0 then
	SetPedComponentVariation(ped, componentID, drawableID, 0, 0)
	end
  activated = false
end

function SetHudPresence(state)
  SendNUIMessage({AxonUIPresence = state})
  hudPresence = state
end

function ShowNotification(message)
  BeginTextCommandThefeedPost("STRING")
  AddTextComponentSubstringPlayerName(message)
  EndTextCommandThefeedPostTicker(true, false)
end

-- Bodycam model check

function CheckBodycam(ped)
	if not bodycammodel then
	return true
	end
	if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
	local tbl_m = Config.bodycam_m
	for i=1, #tbl_m do
		if GetPedDrawableVariation(ped, convertInput(tbl_m[i])[1]) == convertInput(tbl_m[i])[2] then
			componentID = convertInput(tbl_m[i])[1]
			drawableID = convertInput(tbl_m[i])[2]
			texturechangeable = convertInput(tbl_m[i])[3]
			return true
		end
	end
	elseif GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
	local tbl_f = Config.bodycam_f
	for i=1, #tbl_f do
		if GetPedDrawableVariation(ped, convertInput(tbl_f[i])[1]) == convertInput(tbl_f[i])[2] then
		componentID = convertInput(tbl_f[i])[1]
		drawableID = convertInput(tbl_f[i])[2]
		texturechangeable = convertInput(tbl_f[i])[3]
			return true
		end
	end
	else
	return false
end	
end

local function convertInput(input)
	local t1 = tonumber(splitString(input, ":")[1])
	local t2 = tonumber(splitString(input, ":")[2])-1
	local t3 = tonumber(splitString(input, ":")[3])
	return({t1, t2, t3})
end

function splitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
