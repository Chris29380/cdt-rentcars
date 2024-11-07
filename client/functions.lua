function addPed(ped)
    table.insert(pedstable, {
        id = ped
    })
end

function delPed(ped)
    if pedstable then
        if #pedstable then
            for i = 1, #pedstable do
                if pedstable[i].id == ped then
                    local try = 5000
                    while DoesEntityExist(ped) do
                        DeleteEntity(ped)
                        Wait(100)
                        try = try - 100
                        if try == 0 then break end
                    end 
                    table.remove(pedstable, i)
                end
            end
        else
            local try = 5000
            while DoesEntityExist(ped) do
                DeleteEntity(ped)
                Wait(100)
                try = try - 100
                if try == 0 then break end
            end 
            pedstable = {}
        end
    end
end

function initPedTable()
    if pedstable then
        if #pedstable then
            for i = 1, #pedstable do
                local ped = pedstable[i].id
                local try = 5000
                while DoesEntityExist(ped) do
                    DeleteEntity(ped)
                    Wait(100)
                    try = try - 100
                    if try == 0 then break end
                end 
                table.remove(pedstable, i)
            end
            pedstable = {}
        end
    end
end

function initBlips()
    if blips then
        for i = 1, #blips do
            RemoveBlip(blips[i].blipId)
        end
    end
end