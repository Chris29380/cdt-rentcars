isOpen = false
intransac = false

RegisterNetEvent("cdtrent:openUi")
AddEventHandler("cdtrent:openUi", function (data, indexpoint)
    if isOpen == false then
        SendNUIMessage(
            {
                type = "openUi",
                data = data,
                title = Options.TitleMenu,
                currency = Options.currency,
                theme = Options.theme,
                indexpoint = indexpoint,
            }
        )
        SetNuiFocus(true, true)
        isOpen = true 
        intransac = false
    end
end)

RegisterNuiCallback("checkspawnveh", function (data)
    if not intransac then
        local coords = data["datas"]["datap"].coordsspawn
        if ESX.Game.IsSpawnPointClear(coords, 2.5) then
            TriggerServerEvent("cdtrent:checkpay", data)
            intransac = true
        else
            TriggerEvent("cdtrent:noplacetospawn")
            intransac = false
        end    
    end
end)

RegisterNetEvent("cdtrent:closeUI")
AddEventHandler("cdtrent:closeUI", function ()
    SendNUIMessage(
        {
            type = "closeUi",
        }
    )
end)

RegisterNuiCallback('closeUI', function ()
    SetNuiFocus(false,false)
    isOpen = false
    intransac = false
end)