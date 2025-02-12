local savedData = {}

if Config.Core == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Core == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end

local function isDataSaved(data)
    for _, savedDataItem in ipairs(savedData) do
        if savedDataItem.doorcoords == data.doorcoords then
            return true
        end
    end
    return false
end

local function GetCops()
    local cops = 0
    if Config.Core == 'qb-core' then
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v.PlayerData.job.name == Config.PoliceJobName and v.PlayerData.job.onduty then
                cops = cops + 1
            end
        end
    elseif Config.Core == 'esx' then
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == Config.PoliceJobName then
                cops = cops + 1
            end
        end
    end
    return cops
end

RegisterServerEvent('arc-containerrob:saveCoords')
AddEventHandler('arc-containerrob:saveCoords', function(data)
    if not isDataSaved(data) then
        local index = #savedData + 1
        table.insert(savedData, data)
        TriggerClientEvent('arc-containerrob:setTargets', -1, data, index)
        TriggerClientEvent('arc-containerrob:setDoors', -1, savedData)
    end
end)

RegisterServerEvent('arc-containerrob:server:notifyPolice')
AddEventHandler('arc-containerrob:server:notifyPolice', function(coords)
    TriggerClientEvent('arc-containerrob:client:notifyPolice', -1, coords)
end)

RegisterServerEvent('arc-containerrob:updateStatus')
AddEventHandler('arc-containerrob:updateStatus', function(index, newStatus)
    if savedData[index] then
        if newStatus == true then
            for _, v in pairs(savedData[index].cabinets) do
                v.taken = false
            end
        end
        savedData[index].status = newStatus
    end
end)

RegisterServerEvent('arc-containerrob:giveLoot')
AddEventHandler('arc-containerrob:giveLoot', function(containerindex, cabinetindex)
    local ped = GetPlayerPed(source)
    local position = GetEntityCoords(ped)

    if #(position - savedData[containerindex].doorcoords) >= 20 then
        return print('Do something about this modder! ID: '..source)
    end

    local totalAmountofLoot = 0
    local rarity = Config.Loot.Common

    if math.random(100) <= Config.Loot.ChanceOfRare then
        rarity = Config.Loot.Rare
    end

    if rarity.AllowMoney and math.random(100) <= rarity.Money.chance then
        local moneyAmount = math.random(rarity.Money.min, rarity.Money.max)
        exports.ox_inventory:AddItem(source, 'money', moneyAmount)
        totalAmountofLoot = totalAmountofLoot + 1
    end

    if rarity.AllowItems then
        local totalItems = math.random(rarity.Item.min, rarity.Item.max)
        for i = 1, totalItems do
            for _, item in ipairs(rarity.Items) do
                if math.random(100) <= item.chance then
                    if item.minQuantity and item.maxQuantity then
                        local itemQuantity = math.random(item.minQuantity, item.maxQuantity)
                        exports.ox_inventory:AddItem(source, item.name, itemQuantity)
                        totalAmountofLoot = totalAmountofLoot + 1
                    else
                        print("Error: minQuantity or maxQuantity is missing for item", item.name or "unknown")
                    end
                end
            end
        end
    end

    if totalAmountofLoot == 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Konttimurto',
            description = Config.Locales['NothingFound'],
            type = 'error'
        })
    end

    savedData[containerindex].cabinets[cabinetindex].taken = true
end)

RegisterServerEvent('arc-containerrob:onStart')
AddEventHandler('arc-containerrob:onStart', function()
    for k, v in pairs(savedData) do
        TriggerClientEvent('arc-containerrob:setTargets', -1, v, k)
    end
    TriggerClientEvent('arc-containerrob:setDoors', -1, savedData)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for k, v in pairs(savedData) do
        savedData[k].status = true
    end
end)

if Config.Core == 'qb-core' then
    QBCore.Functions.CreateCallback('arc-containerrob:checkData', function(source, cb)
        cb(savedData)
    end)
    QBCore.Functions.CreateCallback('arc-containerrob:checkPoliceCount', function(source, cb)
        cb(GetCops())
    end)
elseif Config.Core == 'esx' then
    ESX.RegisterServerCallback('arc-containerrob:checkData', function(source, cb)
        cb(savedData)
    end)
    ESX.RegisterServerCallback('arc-containerrob:checkPoliceCount', function(source, cb)
        cb(GetCops())
    end)
end
