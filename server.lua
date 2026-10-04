local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pathFinder:getPlayerCoords', function(source, cb, playerName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromName(playerName)

    if targetPlayer then
        local targetPed = GetPlayerPed(targetPlayer.source)
        local targetCoords = GetEntityCoords(targetPed)
        cb(targetCoords)
    else
        MySQL.Async.fetchScalar('SELECT target_coords FROM path_finder WHERE player_name = @playerName', {
            ['@playerName'] = playerName
        }, function(result)
            if result then
                local coords = json.decode(result)
                cb(vector3(coords.x, coords.y, coords.z))
            else
                cb(nil)
            end
        end)
    end
end)

RegisterServerEvent('pathFinder:findPath')
AddEventHandler('pathFinder:findPath', function(playerName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    ESX.TriggerServerCallback('pathFinder:getPlayerCoords', source, function(targetCoords)
        TriggerClientEvent('pathFinder:startTween', source, targetCoords)
    end, playerName)
end)