QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('lng-mission:sv:money')
AddEventHandler('lng-mission:sv:money', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        if not Config.Mission then
            local removeMoney = Config.MoneyAmount
            local currentMoney = Player.PlayerData.money['cash']
            if currentMoney >= removeMoney then
                Player.Functions.RemoveMoney('cash', removeMoney)
                TriggerClientEvent("lng-mission:cl:spawnBag", src)
                Config.Mission = true    
            else
                TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money in cash.', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are in the mission or You do not have enough money in cash.', 'error')
        end   
    end
end)


RegisterNetEvent('lng-mission:sv:addItems')
AddEventHandler('lng-mission:sv:addItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mathItems = Config.Items[math.random(1, #Config.Items)] 
    Player.Functions.AddItem(mathItems, 1)  
    TriggerClientEvent('QBCore:Notify', src, 'You received an item!', 'success')
end)