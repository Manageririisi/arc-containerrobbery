local targets = {}  

if Config.Core == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Core == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
end

AddEventHandler("onClientResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    if Config.Core == 'qb-core' then
        QBCore.Functions.TriggerCallback('arc-containerrob:checkData', function(savedData)
            for k, v in pairs(savedData) do
                if DoorSystemFindExistingDoor(v.doorcoords.x, v.doorcoords.y, v.doorcoords.z) then
                    DoorSystemSetDoorState(k, 1) 
                end
            end
        end)
    elseif Config.Core == 'esx' then
        ESX.TriggerServerCallback('arc-containerrob:checkData', function(savedData)
            for k, v in pairs(savedData) do
                if DoorSystemFindExistingDoor(v.doorcoords.x, v.doorcoords.y, v.doorcoords.z) then
                    DoorSystemSetDoorState(k, 1) 
                end
            end
        end)
    end
    TriggerServerEvent('arc-containerrob:onStart')
end)

Citizen.CreateThread(function()
    while true do
        local objects = GetGamePool('CObject')
        for _, object in pairs(objects) do
            local model = GetEntityModel(object)
            if GetHashKey("portacabin_int_door") == model then
                local doorcoords = GetEntityCoords(object)
                local targetcoords = GetOffsetFromEntityInWorldCoords(object, 1.1, 0.0, 0.0)
                local heading = GetEntityHeading(object)
                local cabinets

                if Config.cabinets == "helnius" then
                    cabinets = {
                        [1] = {coords = GetOffsetFromEntityInWorldCoords(object, 3.75, 0.7, 0.0), size = vec3(1.2, 0.3, 1.0), taken = false, skillcheck = math.random(100)},
                        [2] = {coords = GetOffsetFromEntityInWorldCoords(object, -0.63, 3.0, -0.3), size = vec3(1.2, 1.0, 1.0), taken = false, skillcheck = math.random(100)},
                        [3] = {coords = GetOffsetFromEntityInWorldCoords(object, 4.0, 3.1, -0.3), size = vec3(1.0, 1.0, 1.0), taken = false, skillcheck = math.random(100)},
                        [4] = {coords = GetOffsetFromEntityInWorldCoords(object, 6.3, 0.55, -0.3), size = vec3(1.0, 2.0, 1.5), taken = false, skillcheck = math.random(100)},
                        [5] = {coords = GetOffsetFromEntityInWorldCoords(object, -1.0, 0.5, -0.6), size = vec3(0.5, 2.0, 1.5), taken = false, skillcheck = math.random(100)}
                    }
                elseif Config.cabinets == "slb2k11" then
                    cabinets = {
                        [1] = {coords = GetOffsetFromEntityInWorldCoords(object, 1.75, 3.0, 0.1), size = vec3(1.2, 0.3, 1.0), taken = false, skillcheck = math.random(100)},
                        [2] = {coords = GetOffsetFromEntityInWorldCoords(object, 0.1, 3.1, -0.3), size = vec3(0.9, 0.4, 0.5), taken = false, skillcheck = math.random(100)},
                        [3] = {coords = GetOffsetFromEntityInWorldCoords(object, 3.45, 3.1, -0.3), size = vec3(0.9, 0.4, 0.5), taken = false, skillcheck = math.random(100)},
                        [4] = {coords = GetOffsetFromEntityInWorldCoords(object, 6.3, 1.8, -0.6), size = vec3(0.5, 2.0, 1.5), taken = false, skillcheck = math.random(100)},
                        [5] = {coords = GetOffsetFromEntityInWorldCoords(object, -2.8, 1.8, -0.6), size = vec3(0.5, 2.0, 1.5), taken = false, skillcheck = math.random(100)}
                    }
                end

                local data = {
                    doorcoords = doorcoords,
                    targetcoords = targetcoords,
                    heading = heading,
                    cabinets = cabinets,
                    status = true
                }
                TriggerServerEvent('arc-containerrob:saveCoords', data)
            end
        end
        Citizen.Wait(4000)
    end
end)


if Config.cabinets == "helnius" then
    RegisterNetEvent('arc-containerrob:setDoors')
    AddEventHandler('arc-containerrob:setDoors', function(data)
        for k, v in pairs(data) do
            if not DoorSystemFindExistingDoor(v.doorcoords.x, v.doorcoords.y, v.doorcoords.z, GetHashKey("portacabin_int_door")) then
                AddDoorToSystem(k, GetHashKey("portacabin_int_door"), v.doorcoords, false)
            end
            DoorSystemSetDoorState(k, v.status and 1 or 0)
        end
    end)
elseif Config.cabinets == "slb2k11" then
    RegisterNetEvent('arc-containerrob:setDoors')
    AddEventHandler('arc-containerrob:setDoors', function(data)
        for k, v in pairs(data) do
            if not DoorSystemFindExistingDoor(v.doorcoords.x, v.doorcoords.y, v.doorcoords.z, GetHashKey("ex_prop_door_lowbank_roof")) then
                AddDoorToSystem(k, GetHashKey("ex_prop_door_lowbank_roof"), v.doorcoords, false)
            end
            DoorSystemSetDoorState(k, v.status and 1 or 0)
        end
    end)
end

local function CheckPoliceCount(cb)
    if Config.Core == 'qb-core' then
        QBCore.Functions.TriggerCallback('arc-containerrob:checkPoliceCount', function(count)
            cb(count)
        end)
    elseif Config.Core == 'esx' then
        ESX.TriggerServerCallback('arc-containerrob:checkPoliceCount', function(count)
            cb(count)
        end)
    end
end

RegisterNetEvent('arc-containerrob:setTargets')
AddEventHandler('arc-containerrob:setTargets', function(data, index)
    if targets[index] then return end  
    targets[index] = true
    exports.ox_target:addBoxZone({
        coords = data.targetcoords,
        size = vec3(0.5, 0.3, 0.5),
        rotation = data.heading,
        debug = Config.Debug,
        options = {
            {
                icon = 'fa-solid fa-screwdriver',
                label = Config.Locales['LockpickDoor'],
                canInteract = function()
                    return DoorSystemGetDoorState(index) == 1 and exports.ox_inventory:GetItemCount(Config.Containers.LockpickItem) > 0
                end,
                onSelect = function()
                    CheckPoliceCount(function(cops)
                        if cops >= Config.MinPolice then
                            local result = exports["t3-lockpick"]:startLockpick("lockpick", 2, 6)
                            if not result then
                                lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['YouFailed'], type = 'error' })
                                ExecuteCommand('emotecancel')
                            else
                                DoorSystemSetDoorState(index, 0)
                                TriggerServerEvent('arc-containerrob:updateStatus', index, false)
                                lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['DoorOpened'], type = 'success' })
                                ExecuteCommand('emotecancel')
                                local coords = GetEntityCoords(PlayerPedId())
                                if Config.policeChance then
                                    if math.random(1, 100) <= Config.policeChance then
                                        Dispatch(type) 
                                    end
                                end

                                if math.random(1, 100) <= Config.Worker then
                                    Citizen.SetTimeout(10000, function()
                                        for i = 1, 4 do
                                            local angle = math.random() * 2 * math.pi
                                            local distance = math.random(5, 15)
                                            local offsetX = math.cos(angle) * distance
                                            local offsetY = math.sin(angle) * distance
                                            local worker = CreatePed(4, GetHashKey("s_m_y_construct_01"), coords.x + offsetX, coords.y + offsetY, coords.z, 0.0, true, true)
                                            if i == 1 then
                                                GiveWeaponToPed(worker, GetHashKey("WEAPON_HAMMER"), 1, false, true)
                                            end
                                            TaskCombatPed(worker, PlayerPedId(), 0, 16)
                                        end
                                    end)
                                end
                            end
                        else
                            lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['NotEnoughPolice'], type = 'error' })
                        end
                    end)
                end
            },
            {
                icon = 'fa-solid fa-screwdriver',
                label = Config.Locales['BreakDoor'],
                canInteract = function()
                    return DoorSystemGetDoorState(index) == 1 and exports.ox_inventory:GetItemCount(Config.Containers.BreakDoorItem) > 0
                end,
                onSelect = function()
                    CheckPoliceCount(function(cops)
                        if cops >= Config.MinPolice then
                            local coords = GetEntityCoords(PlayerPedId())
                            if lib.progressCircle({
                                label = Config.Locales['Breaking'],
                                duration = 10000,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = { car = true, move = true },
                                anim = { dict = "missfbi3_toothpull", clip = "pull_tooth_loop_weak_player" },
                            }) then
                                DoorSystemSetDoorState(index, 0)
                                TriggerServerEvent('arc-containerrob:updateStatus', index, false)
                                lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['DoorOpened'], type = 'success' })
                                if Config.policeChance then
                                    if math.random(1, 100) <= Config.policeChance then
                                        Dispatch(type) 
                                    end
                                end
                                if math.random(1, 100) <= Config.Worker then
                                    Citizen.SetTimeout(10000, function()
                                        for i = 1, 4 do
                                            local angle = math.random() * 2 * math.pi
                                            local distance = math.random(15, 25)
                                            local offsetX = math.cos(angle) * distance
                                            local offsetY = math.sin(angle) * distance
                                            local worker = CreatePed(4, GetHashKey("s_m_y_construct_01"), coords.x + offsetX, coords.y + offsetY, coords.z, 0.0, true, true)
                                            if i == 1 then
                                                GiveWeaponToPed(worker, GetHashKey("WEAPON_HAMMER"), 1, false, true)
                                            end
                                            TaskCombatPed(worker, PlayerPedId(), 0, 16)
                                        end
                                    end)
                                end
                            end
                        else
                            lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['NotEnoughPolice'], type = 'error' })
                        end
                    end)
                end
            },
         
            {
                icon = 'fa-solid fa-lock',
                label = Config.Locales['LockDoor'],
                canInteract = function()
             
                    local playerData = QBCore.Functions.GetPlayerData()
                    return playerData.job.name == 'police' and DoorSystemGetDoorState(index) == 0
                end,
                onSelect = function()
                    if lib.progressCircle({
                        label = Config.Locales['Locking'],
                        duration = 20000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = { car = true, move = true },
                        anim = { dict = "anim@heists@keycard@", clip = "exit" },
                    }) then
                        DoorSystemSetDoorState(index, 1) 
                        TriggerServerEvent('arc-containerrob:updateStatus', index, true)
                        lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['DoorLocked'], type = 'success' })
                    else
                        lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['Canceled'], type = 'error' })
                    end
                end
            }
        }
    })
    


for k, v in pairs(data.cabinets) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        rotation = data.heading,
        debug = Config.Debug,
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Config.Locales['SearchCabinet'],
                distance = 1,
                canInteract = function()
                    return DoorSystemGetDoorState(index) == 0
                end,
                onSelect = function()
                    QBCore.Functions.TriggerCallback('arc-containerrob:checkData', function(savedData)
                        if savedData[index].cabinets[k].taken then
                            lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['CabinetSearched'], type = 'error' })
                        else
                            if v.skillcheck <= Config.Containers.Cabinets.ChanceOfSkillcheck then
                                local success = exports[Config.UIExport]:Untangle(3, {
                                    numberOfNodes = 12,
                                    duration = 15000,
                                })
                                if not success then
                                    lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['YouFailed'], type = 'error' })
                                    return
                                end
                            end
                            if lib.progressCircle({
                                label = Config.Locales['CabinetSearching'],
                                duration = Config.cabinettime,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = { car = true, move = true },
                                anim = { dict = "missexile3", clip = "ex03_dingy_search_case_base_michael" },
                            }) then
                                TriggerServerEvent('arc-containerrob:giveLoot', index, k)
                            else 
                                lib.notify({ title = Config.Locales['ContainerRobbery'], description = Config.Locales['Canceled'], type = 'error' })
                            end
                        end
                    end)
                end
            }
        }
    })
end
end)