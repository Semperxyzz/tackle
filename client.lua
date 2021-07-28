-- Register the command to be used (gudxuepqvi means nothing its just a random string)
RegisterCommand('gudxuepqvi', function()
	polTackle()
end)
TriggerEvent("chat:removeSuggestion", "/gudxuepqvi")

-- Keybind
RegisterKeyMapping('gudxuepqvi', Config.en.commandlabel, 'keyboard', 'y')

-- If resource gets restarted make sure players can tackle
LocalPlayer.state:set('canTackle', true)

-- Tackle timer
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- for that 0.0 resmon
        if LocalPlayer.state.canTackle == false then
            Citizen.Wait(Config.TTT)
            LocalPlayer.state:set('canTackle', true)
        end
    end
end)

-- Tackle logic
function polTackle()
    if LocalPlayer.state.canTackle and ESX.PlayerData.job.name == 'police' then
        if not IsPedInAnyVehicle(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
            local player, playerDistance = ESX.Game.GetClosestPlayer()
            --print(player .. " " ..  playerDistance)
            if playerDistance ~= -1 and playerDistance <= 1.5 then
                TriggerServerEvent("tackle_tackle", GetPlayerServerId(player))
            end 
            SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
        end
        LocalPlayer.state:set('canTackle', false)
    end
end

-- Stun targetPlayer for 8s
RegisterNetEvent("tackle_tackleragdoll")
AddEventHandler("tackle_tackleragdoll", function()
    SetPedToRagdoll(PlayerPedId(), 8000, 8000, 0, 0, 0, 0)
end)