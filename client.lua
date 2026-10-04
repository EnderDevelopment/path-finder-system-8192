local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local function OpenPathFinderGUI()
    local playerName = ''

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'path_finder', {
        title = Config.GUI.Title
    }, function(data, menu)
        playerName = data.value
        menu.close()
        TriggerServerEvent('pathFinder:findPath', playerName)
    end, function(data, menu)
        menu.close()
    end)
end

RegisterCommand('pathfinder', function()
    OpenPathFinderGUI()
end, false)

RegisterNetEvent('pathFinder:startTween')
AddEventHandler('pathFinder:startTween', function(targetCoords)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if targetCoords == nil then
        targetCoords = Config.DefaultCoords
    end

    Citizen.CreateThread(function()
        Citizen.Wait(Config.TweenTime)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z)
        DoScreenFadeIn(500)
    end)
end)