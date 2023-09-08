QBCore = exports['qb-core']:GetCoreObject()
local MissionStarted = false

local function MissionBlip(data)
    for _, v in pairs(data) do
        -- create Blips
        if v.BlipsCoords ~= nil and v.showBlip == true then
            Blip = AddBlipForCoord(v.BlipsCoords.x, v.BlipsCoords.y, v.BlipsCoords.z)
        elseif v.BlipsCoords == nil and v.showBlip == true then
            Blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
        end
        SetBlipAsShortRange(Blip, true)
        if v.radius ~= nil then
            if v.showBlip == true then
                SetBlipSprite(Blip, 1)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(Blip)
                local RadiusBlip = AddBlipForRadius(v.coord.x, v.coord.y, v.coord.z, v.radius)

                -- AddCircleZone(v.name, v.llegal, v.coord, v.radius, {
                --     name = "circle_zone",
                --     debugPoly = DEBUG
                -- })
                SetBlipRotation(RadiusBlip, 0)

                
                
                SetBlipColour(RadiusBlip, 1)
                

                SetBlipAlpha(RadiusBlip, 64)
            end
        else
            SetBlipSprite(Blip, 442)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(Blip)
        end
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.6)
        SetBlipColour(Blip, 49)
    end
end
-- Config.BagLocation[rnd]["x"], Config.BagLocation[rnd]["y"], Config.BagLocation[rnd]["z"]
local propModelHash = GetHashKey("xm_prop_x17_bag_01a")
RegisterNetEvent('lng-mission:cl:spawnBag')
AddEventHandler("lng-mission:cl:spawnBag", function() 
    rnd = math.random(1, #Config.BagLocation)
    MissionBlip(Config.SearchingBlip)
    created_object = CreateObject(propModelHash, Config.BagLocation[rnd]["x"], Config.BagLocation[rnd]["y"], Config.BagLocation[rnd]["z"] , 1, 0, 1)
    PlaceObjectOnGroundProperly(created_object)
    FreezeEntityPosition(created_object,true)
    QBCore.Functions.Notify('Go find in the Searching Area', "primary", 7500)
    -- print(Config.BagLocation[rnd]["x"], Config.BagLocation[rnd]["y"], Config.BagLocation[rnd]["z"])
end)
    

RegisterNetEvent("lng-mission:cl:removeBag")
AddEventHandler("lng-mission:cl:removeBag", function()
    MissionStarted = false
    DeleteObject(created_object)
end)


RegisterNetEvent('lng-mission:cl:progbar')
AddEventHandler('lng-mission:cl:progbar', function()
    QBCore.Functions.Progressbar('loot:bag', 'Looting', 5000, false, true, { 
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        
    }, {}, {}, function() -- Play When Done
        TriggerServerEvent('lng-mission:sv:addItems')
        TriggerEvent("lng-mission:cl:removeBag")
    end, function() -- Play When Cancel
        return;
    end)
    
    
end)

Citizen.CreateThread(function() 
    exports['qb-target']:AddTargetModel("xm_prop_x17_bag_01a", {
        options = {
            { 
                type = "client",
                event = "lng-mission:cl:progbar",
                icon = "fas fa-bag-shopping",
                label = "Loot The Bag!",
            },
        },
        distance = 3.0 
    })
end)

Citizen.CreateThread(function()
    LesterHash = Config.MissionPed
    QBCore.Functions.LoadModel(LesterHash)
    local Lester = CreatePed(0, LesterHash, 821.43, -2339.74, 29.33, 233.1 , false, false)
    SetPedFleeAttributes(Lester, 0, 0)
    SetPedDiesWhenInjured(Lester, false)
    SetPedKeepTask(Lester, true)
    SetBlockingOfNonTemporaryEvents(Lester, true)
    SetEntityInvincible(Lester, true)
    FreezeEntityPosition(Lester, true)
    exports['qb-target']:AddTargetModel(LesterHash, {
        options = {
            { 
                type = "server",
                event = "lng-mission:sv:money",
                icon = "fas fa-bag-shopping",
                label = "Start the mission",
            },
        },
        distance = 3.0 
    })
end)