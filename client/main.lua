CDT = exports['cdt-lib']:getCDTLib()


-- locals

pedstable = {}
blips = {}
locvehs = {}
hasgetdatas = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
    Citizen.Wait(2000)
    -- call triggers
    if hasgetdatas == false then
        hasgetdatas = true
        TriggerEvent("cdtrent:blips")
        TriggerEvent("cdtrent:createpeds")
        TriggerEvent("cdtrent:getlocvehscli")
    end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


RegisterNetEvent('onResourceStart')
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        Citizen.Wait(300)
        -- call trigger
        if hasgetdatas == false then
            hasgetdatas = true
            TriggerEvent("cdtrent:blips")
            TriggerEvent("cdtrent:createpeds")
            TriggerEvent("cdtrent:getlocvehscli")
        end
    end
end)

RegisterNetEvent('onResourceStop')
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        initPedTable()
        initBlips()
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--------------------------------------------------------------------
--- generate blips
--------------------------------------------------------------------
RegisterNetEvent("cdtrent:blips")
AddEventHandler("cdtrent:blips", function ()
    if Options.peds then
        for i = 1, #Options.peds do
            if Options.peds[i]["modelped"] ~= "" then
                TriggerEvent("cdtrent:generateblips", Options.peds[i]["coords"])
            else
                print("no modelped in Options.peds["..i.."]")
            end
        end
    else
        print('no Options ped')
    end
end)

RegisterNetEvent("cdtrent:generateblips")
AddEventHandler("cdtrent:generateblips", function (coordsb)
    local type = Options.blip.type
    local color = Options.blip.color
    local scale = Options.blip.scale
    local label = Options.blip.label
    local blip = AddBlipForCoord(coordsb.x, coordsb.y, coordsb.z)
    SetBlipDisplay(blip, 4)
    SetBlipSprite(blip, tonumber(type))
    SetBlipColour(blip, tonumber(color))
    SetBlipScale(blip, tonumber(scale))
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, {blipId = blip})
end)

--------------------------------------------------------------------
--- loop peds
--------------------------------------------------------------------

RegisterNetEvent("cdtrent:createpeds")
AddEventHandler("cdtrent:createpeds", function ()
    if Options.peds then
        for i = 1, #Options.peds do
            if Options.peds[i]["modelped"] ~= "" then
                TriggerEvent("cdtrent:loopped", Options.peds[i], i)
            else
                print("no modelped in Options.peds["..i.."]")
            end
        end
    else
        print('no Options ped')
    end
end)

RegisterNetEvent("cdtrent:loopped")
AddEventHandler("cdtrent:loopped", function (data, indexpoint)
    local ispedloaded = false
    local text = data["text"]
    local textstore = Options.keylabel.." "..data["textstore"]
    local acttext = Options.keylabel.." "..text
    local keycode = Options.keycode
    local modelped = data["modelped"]
    local coordsped = data["coords"]
    local vec3ped = vector3(coordsped.x, coordsped.y, coordsped.z)
    local headingped = coordsped.w
    local ped
    local anim = data["anim"]
    local dict = data["dict"]
    local scenario = data["scenario"]
    local cars = data["cars"]
    local theme = Options.theme or "Orange"
    Citizen.CreateThread(function ()
        while true do
            local coordsP = GetEntityCoords(PlayerPedId())
            local distance = #(coordsP - vec3ped)
            local vehped = GetVehiclePedIsIn(PlayerPedId(), false)
            if distance >= 100 then
                if ispedloaded == true then
                    delPed(ped)  
                    ispedloaded = false
                end
                Wait(1000)
            end
            if distance < 100 and distance >= 50 then
                if ispedloaded == true then
                    delPed(ped)   
                    ispedloaded = false
                end
                Wait(500)
            end
            if distance < 50 and distance >= 5 then
                if ispedloaded == false then
                    ped = CDT.Functions.cPed(modelped, coordsped, headingped, anim, dict, scenario, false)
                    ispedloaded = true
                    Wait(100)
                    addPed(ped)
                    
                end
                Wait(500)
            end
            if distance < 5 and distance >= 1.5 then
                if ispedloaded == false then
                    ped = CDT.Functions.cPed(modelped, coordsped, coordsped.w, anim, dict, scenario, false)
                    ispedloaded = true
                    Wait(100)
                    addPed(ped)
                end
                if vehped and vehped > 0 then
                    if Options.storeveh == true then
                        local vehprops = ESX.Game.GetVehicleProperties(vehped)
                        local pedseat = GetPedInVehicleSeat(vehped, -1)
                        if pedseat == PlayerPedId() then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, textstore, 0, 255, 255, 255, 255, true)
                            if IsControlJustPressed(1, keycode) then
                                TriggerEvent("cdtrent:storeveh", vehped, vehprops.plate)
                            end
                        end
                    else
                        if isOpen == false then
                            if theme == "Orange" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 69, 0, 255, true)
                            end
                            if theme == "Red" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 0, 0, 255, true)
                            end
                            if theme == "White" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 255, 255, 255, true)
                            end
                            if theme == "Blue" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 0, 116, 255, 255, true)
                            end
                            if theme == "Green" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 2, 206, 113, 255, true)
                            end
                        end
                    end   
                else
                    if isOpen == false then
                        if theme == "Orange" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 69, 0, 255, true)
                        end
                        if theme == "Red" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 0, 0, 255, true)
                        end
                        if theme == "White" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 255, 255, 255, true)
                        end
                        if theme == "Blue" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 0, 116, 255, 255, true)
                        end
                        if theme == "Green" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 2, 206, 113, 255, true)
                        end
                        if IsControlJustPressed(1, keycode) then
                            TriggerEvent("cdtrent:openUi", data)
                        end
                    end  
                end
            end
            if distance < 1.5 then
                if ispedloaded == false then
                    ped = CDT.Functions.cPed(modelped, coordsped, coordsped.w, anim, dict, scenario, false)
                    ispedloaded = true
                    Wait(100)
                    addPed(ped)
                end
                if vehped and vehped > 0 then
                    if Options.storeveh == true then
                        local vehprops = ESX.Game.GetVehicleProperties(vehped)
                        local pedseat = GetPedInVehicleSeat(vehped, -1)
                        if pedseat == PlayerPedId() then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, textstore, 0, 255, 255, 255, 255, true)
                            if IsControlJustPressed(1, keycode) then
                                TriggerEvent("cdtrent:storeveh", vehped, vehprops.plate)
                            end
                        end
                    else
                        if isOpen == false then
                            if theme == "Orange" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 69, 0, 255, true)
                            end
                            if theme == "Red" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 0, 0, 255, true)
                            end
                            if theme == "White" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 255, 255, 255, 255, true)
                            end
                            if theme == "Blue" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 0, 116, 255, 255, true)
                            end
                            if theme == "Green" then
                                CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, text, 0, 2, 206, 113, 255, true)
                            end
                        end
                    end   
                else
                    if isOpen == false then
                        if theme == "Orange" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, acttext, 0, 255, 69, 0, 255, true)
                        end
                        if theme == "Red" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, acttext, 0, 255, 0, 0, 255, true)
                        end
                        if theme == "White" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, acttext, 0, 255, 255, 255, 255, true)
                        end
                        if theme == "Blue" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, acttext, 0, 0, 116, 255, 255, true)
                        end
                        if theme == "Green" then
                            CDT.Functions.DrawText3D(coordsped.x, coordsped.y, coordsped.z + 0.1, acttext, 0, 2, 206, 113, 255, true)
                        end
                        if IsControlJustPressed(1, keycode) then
                            TriggerEvent("cdtrent:openUi", data, indexpoint)
                        end
                    end
                end   
            end
            Wait(0)
        end
    end)
end)

-------------------------------------------------------------------
--- datas
-------------------------------------------------------------------

RegisterNetEvent("cdtrent:getlocvehscli")
AddEventHandler("cdtrent:getlocvehscli", function ()
    TriggerServerEvent("cdtrent:getlocvehs")
end)

RegisterNetEvent("cdtrent:getdatalocvehscli")
AddEventHandler("cdtrent:getdatalocvehscli", function (data)
    locvehs = data
end)

-------------------------------------------------------------------
--- spawn vehicle
-------------------------------------------------------------------

RegisterNetEvent("cdtrent:spawnveh")
AddEventHandler("cdtrent:spawnveh", function (data)
    local coordspwn = data["datas"]["datap"].coordsspawn
    local coordspawn = vector3(coordspwn.x, coordspwn.y, coordspwn.z)
    local heading = coordspwn.w
    local model = data["datas"]["dataveh"].model
    local plate = CDT.Functions.GeneratePlate(Options.plateLetters, Options.plateNumbers)
    local try = 1000
    while not plate do
        plate = CDT.Functions.GeneratePlate(CDT.Functions.GeneratePlate(Options.plateLetters, Options.plateNumbers))
        Wait(10)
        try = try - 10
        if try == 0 then break end
    end
    ESX.Game.SpawnVehicle(model, coordspawn, heading, function(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        if DoesEntityExist(vehicle) then
            TriggerServerEvent("cdtrent:addvehtable", plate)
        end
        TriggerEvent("cdtrent:closeUI")
    end)
end)