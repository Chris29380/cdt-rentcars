CDT = exports['cdt-lib']:getCDTLib()


-- locals

local locvehs = {}

RegisterServerEvent('onResourceStart')
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        -- call triggers
    end
end)

RegisterNetEvent("cdtrent:checkpay", function (data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if data then
            local indexpoint = tonumber(data["datas"]["indexp"])
            local indexveh = tonumber(data["datas"]["indexveh"] + 1)
            local price = data["datas"]["dataveh"].price
            local accountMoney = xPlayer.getAccount('money').money
            local accountBank = xPlayer.getAccount('bank').money
            if price and price >= 0 then
                local priceverif = Options.peds[indexpoint]["cars"][indexveh].price
                if price == priceverif then
                    if accountMoney >= price then
                        xPlayer.removeAccountMoney('money', price)
                        TriggerClientEvent("cdtrent:spawnveh", xPlayer.source, data)
                        TriggerClientEvent("cdtrent:notifpaycash", xPlayer.source, price)
                    elseif accountBank >= price then
                        xPlayer.removeAccountMoney('bank', price)
                        TriggerClientEvent("cdtrent:spawnveh", xPlayer.source, data)
                        TriggerClientEvent("cdtrent:notifpaycash", xPlayer.source, price)
                    else                        
                        TriggerClientEvent("cdtrent:notifnomoney", xPlayer.source)
                    end
                else
                    print("Price is different than Price in Config")
                end
            else
                print('no price - cdtrent:checkpay')
            end
        else
            print('no data - cdtrent:checkpay')
        end
    else
        print('no xPlayer - cdtrent:checkpay')
    end
end)

RegisterNetEvent("cdtrent:getlocvehs")
AddEventHandler("cdtrent:getlocvehs", function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerClientEvent("cdtrent:getdatalocvehscli", xPlayer.source, locvehs)
    else
        print('no xPlayer - cdtrent:addvehtable')
    end
end)

RegisterNetEvent("cdtrent:getalllocvehs")
AddEventHandler("cdtrent:getalllocvehs", function (xPlayer)
    if xPlayer then
        TriggerClientEvent("cdtrent:getdatalocvehscli", -1, locvehs)
    else
        print('no xPlayer - cdtrent:addvehtable')
    end
end)

RegisterNetEvent("cdtrent:addvehtable")
AddEventHandler("cdtrent:addvehtable", function (plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if plate then
            table.insert(locvehs, {plate = plate})
            TriggerEvent("cdtrent:getalllocvehs", xPlayer)
        else
            print('no Plate - cdtrent:addvehtable')
        end
    else
        print('no xPlayer - cdtrent:addvehtable')
    end
end)

RegisterNetEvent("cdtrent:delvehtable")
AddEventHandler("cdtrent:delvehtable", function (veh, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local findveh = false
        if plate then
            if locvehs and #locvehs > 0 then
                for i = 1, #locvehs do
                    if locvehs[i].plate == plate then
                        table.remove(locvehs, i)
                        TriggerClientEvent("cdtrent:delveh", xPlayer.source, veh)
                        findveh = true
                    end
                end
                if findveh == false then
                    TriggerClientEvent("cdtrent:notifnovehloc", xPlayer.source)
                end
                TriggerEvent("cdtrent:getalllocvehs", xPlayer)
            else
                TriggerClientEvent("cdtrent:notifnovehloc", xPlayer.source)
                print("no locvehs to delete...")
            end
        else
            print('no Plate - cdtrent:addvehtable')
        end
    else
        print('no xPlayer - cdtrent:addvehtable')
    end
end)