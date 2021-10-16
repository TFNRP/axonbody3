-- globals
local hudForceHide = false
local hudPresence
local activated = false

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

-- Activation and deactivation

if Config.CommandBinding then
  RegisterKeyMapping('axon', 'Toggle Axon Body 3', 'keyboard', Config.CommandBinding)
end
RegisterCommand('axon', function ()
  if activated then
    DeactivateAB3()
    ShowNotification("~y~Axon Body 3~s~ has ~r~stopped recording~s~.")
  else
    if not Config:CommandAccessHandling() then
      ShowNotification("You have to be ~r~on duty~s~ to enable ~y~Axon Body 3~s~.")
    else
      ActivateAB3()
      ShowNotification("~y~Axon Body 3~s~ has ~g~started recording~s~.")
    end
  end
end)

RegisterCommand('axonon', function ()
  if not Config:CommandAccessHandling() then
    ShowNotification("You have to be ~r~on duty~s~ to use ~y~Axon Body 3~s~.")
  else
    if activated then
      ShowNotification("~y~Axon Body 3~s~ is already ~g~recording~s~.")
    else
      ActivateAB3()
      ShowNotification("~y~Axon Body 3~s~ has ~g~started recording~s~.")
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
  if DoesEntityExist(ped) and (IsPedInAnyVehicle(ped) == IsPedInAnyVehicle(otherPed)) or not IsPedInAnyVehicle(ped) then
    local volume = 0.05
    local radius = 10
    
    local playerCoords = GetEntityCoords(ped);
    local targetCoords = GetEntityCoords(otherPed);
    
    local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z);
    local distanceVolumeMultiplier = volume / radius;
    local distanceVolume = volume - (distance * distanceVolumeMultiplier);
    
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

  -- beeper
  Citizen.CreateThread(function()
    Citizen.Wait(12e4)
    while activated do
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
