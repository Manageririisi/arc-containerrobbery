Config = {}

Config.Debug = false
Config.Core = 'qb-core' -- 'qb-core' or 'esx'
Config.dispatch = 'custom' -- 'custom', 'ps' or 'cd'
Config.cabinets = "helnius" -- "helnius" or "slb2k11"
Config.UIExport = "arc-ui" -- name of you UI export (https://github.com/Byte-Labs-Studio/bl_ui/releases)
Config.policeChance = 100 -- chance of the police being alerted

Config.MinPolice = 1 -- Minimum number of police required to start robbery
Config.PoliceJobName = 'police' -- Name of the police job

Config.Containers = {
    BreakDoorItem = 'WEAPON_CROWBAR', -- The name of the item needed to break the door open
    LockpickItem = 'lockpick', -- The name of the item needed for lockpicking the door
    Cabinets = {
        ChanceOfSkillcheck = 0, -- What is the chance of a skillcheck when searching a cabinet
    },
}
Config.cabinettime = 20000 -- How long does it take to search a cabinet 1000 = 1 second
Config.Worker = 33 -- chance that angry workers spawn
Config.Loot = {
    ChanceOfRare = 5,
    Common = { 
        AllowItems = true,
        AllowMoney = true,
        Money = { min = 50, max = 100, chance = 20 }, 
        Item = { min = 1, max = 3 }, 
        Items = { 
            { name = 'paper', minQuantity = 1, maxQuantity = 3, chance = 10 },
            { name = 'shovel', minQuantity = 1, maxQuantity = 1, chance = 8 },
            { name = 'phone', minQuantity = 1, maxQuantity = 1, chance = 10 },
            { name = 'money', minQuantity = 100, maxQuantity = 200, chance = 15 },
            { name = 'screwdriverset', minQuantity = 1, maxQuantity = 1, chance = 8 },
            { name = 'keys', minQuantity = 1, maxQuantity = 2, chance = 7 },
            { name = 'copper', minQuantity = 1, maxQuantity = 3, chance = 12 },
            { name = 'iron', minQuantity = 1, maxQuantity = 3, chance = 12 },
            { name = 'steel', minQuantity = 1, maxQuantity = 2, chance = 10 },
            { name = 'silver', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'diamond', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'emerald', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'cash_bag', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'inked_cash_bag', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'lockpick', minQuantity = 1, maxQuantity = 2, chance = 10 },
            { name = 'goldbar', minQuantity = 1, maxQuantity = 1, chance = 2 },
            { name = 'rope', minQuantity = 1, maxQuantity = 2, chance = 8 },
            { name = 'jerrycan', minQuantity = 1, maxQuantity = 1, chance = 7 },
            { name = 'engine_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'transmission_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'brake_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'turbo_d', minQuantity = 1, maxQuantity = 1, chance = 4 },
            { name = 'nitrous', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'hacking_device', minQuantity = 1, maxQuantity = 1, chance = 2 },
            { name = 'goldchain', minQuantity = 1, maxQuantity = 2, chance = 8 },
            { name = '10kgoldchain', minQuantity = 1, maxQuantity = 1, chance = 6 },
            { name = 'diamond_ring', minQuantity = 1, maxQuantity = 2, chance = 7 },
            { name = 'rolex', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'electronickit', minQuantity = 1, maxQuantity = 1, chance = 4 },
        }
    },

    Rare = { 
        AllowItems = true,
        AllowMoney = true,
        Money = { min = 50, max = 100, chance = 5 },
        Item = { min = 1, max = 3 },
        Items = {
            { name = 'mdlean', minQuantity = 1, maxQuantity = 3, chance = 10 },
            { name = 'shovel', minQuantity = 1, maxQuantity = 1, chance = 8 },
            { name = 'phone', minQuantity = 1, maxQuantity = 1, chance = 10 },
            { name = 'money', minQuantity = 100, maxQuantity = 200, chance = 15 },
            { name = 'screwdriverset', minQuantity = 1, maxQuantity = 1, chance = 8 },
            { name = 'goldbar', minQuantity = 1, maxQuantity = 2, chance = 7 },
            { name = 'copper', minQuantity = 1, maxQuantity = 3, chance = 12 },
            { name = 'iron', minQuantity = 1, maxQuantity = 3, chance = 12 },
            { name = 'steel', minQuantity = 1, maxQuantity = 2, chance = 10 },
            { name = 'silver', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'diamond', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'emerald', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'cash_bag', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'inked_cash_bag', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'armour_s', minQuantity = 1, maxQuantity = 2, chance = 10 },
            { name = 'heroinvial', minQuantity = 1, maxQuantity = 1, chance = 2 },
            { name = 'rope', minQuantity = 1, maxQuantity = 2, chance = 8 },
            { name = 'jerrycan', minQuantity = 1, maxQuantity = 1, chance = 7 },
            { name = 'engine_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'transmission_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'brake_d', minQuantity = 1, maxQuantity = 1, chance = 5 },
            { name = 'turbo_d', minQuantity = 1, maxQuantity = 1, chance = 4 },
            { name = 'nitrous', minQuantity = 1, maxQuantity = 1, chance = 3 },
            { name = 'hacking_device', minQuantity = 1, maxQuantity = 1, chance = 2 },
            { name = 'pkahva', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'rkahva', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'prunko', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'pliipaisin', minQuantity = 1, maxQuantity = 1, chance =  1},
            { name = 'pjousi', minQuantity = 1, maxQuantity = 1, chance = 1 },
            
            { name = 'rsylinteri', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'mrunko', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'rliipaisin', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'aluistin', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'kliipaisin', minQuantity = 1, maxQuantity = 1, chance = 1 },
            
            { name = 'ajousi', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'akathva', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'mliipaisin', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'krunko', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'mkahva', minQuantity = 1, maxQuantity = 1, chance = 1 },
            
            { name = 'apiippu', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'mrunko', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'rjousi', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'aliipaisin', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'kkahva', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_pistol', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_snspistol', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_heavypistol', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_revolver', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_doubleaction', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_sawnoff', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_uzi', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'blueprint_ak12', minQuantity = 1, maxQuantity = 1, chance = 1 },
            { name = 'goldchain', minQuantity = 1, maxQuantity = 3, chance = 12 },
            { name = '10kgoldchain', minQuantity = 1, maxQuantity = 2, chance = 10 },
            { name = 'diamond_ring', minQuantity = 1, maxQuantity = 3, chance = 11 },
            { name = 'rolex', minQuantity = 1, maxQuantity = 2, chance = 9 },
            { name = 'electronickit', minQuantity = 1, maxQuantity = 2, chance = 8 },
        }
    }
}


function Dispatch(type)
    if Config.dispatch == "custom" then
       exports['arc-mdt']:CustomAlert({
            coords = GetEntityCoords(PlayerPedId()),
            info = {
                {
                    label = 'Kansalainen soitti nähneensä henkilön ronklaavan konttia',
                    icon = '',
                },
            },
            code = '10-11',
            offense = 'Konttimurto',
            blip = 310,
        })
    elseif Config.dispatch == "ps" then
        exports["ps-dispatch"]:CustomAlert({
            coords = GetEntityCoords(PlayerPedId()),
            message = Config.stations[type].name .. " Robbery",
            dispatchCode = "10-15",
            description = Config.stations[type].name .. " Robbery In Progress",
            radius = 0,
            sprite = 311,
            color = 4,
            scale = 1.5,
            length = 2,
        })
    elseif Config.dispatch == "cd" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.police,
            coords = data.coords,
            title = '10-15 - ' .. Config.stations[type].name .. ' Robbery',
            message = 'An anonymous caller has reported a ' .. data.sex .. ' robbing a ' .. Config.stations[type].name .. ' at ' .. data.street,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 311,
                scale = 1.2,
                colour = 4,
                flashes = false,
                text = '911 - ' .. Config.stations[type].name .. ' Robbery',
                time = 2,
                radius = 50,
            }
        })
    end
end


