RegisterNetEvent("cdtrent:notifpaycash")
AddEventHandler("cdtrent:notifpaycash", function (price)
    local currency = Options.currency
    local type = "banksuccess"
    local msg = tr[Options.language]["cashpaid"]..price.." "..currency
    local timer = 4500
    local id = "rentpaiementok"
    Notifs(type,msg,timer,id)
end)

RegisterNetEvent("cdtrent:notifpaybank")
AddEventHandler("cdtrent:notifpaybank", function (price)
    local currency = Options.currency
    local type = "banksuccess"
    local msg = tr[Options.language]["bankpaid"]..price.." "..currency
    local timer = 4500
    local id = "rentpaiementok"
    Notifs(type,msg,timer,id)
end)

RegisterNetEvent("cdtrent:notifnomoney")
AddEventHandler("cdtrent:notifnomoney", function ()
    local type = "bankerror"
    local msg = tr[Options.language]["nomoney"]
    local timer = 4500
    local id = "rentpaiementko"
    Notifs(type,msg,timer,id)
end)

RegisterNetEvent("cdtrent:notifnovehloc")
AddEventHandler("cdtrent:notifnovehloc", function ()
    local type = "renterror"
    local msg = tr[Options.language]["nolocveh"]
    local timer = 4500
    local id = "storevehko"
    Notifs(type,msg,timer,id)
end)

RegisterNetEvent("cdtrent:noplacetospawn")
AddEventHandler("cdtrent:noplacetospawn", function ()
    local type = "rentinfo"
    local msg = tr[Options.language]["noplacespawn"]
    local timer = 4500
    local id = "spawnvehplaceko"
    Notifs(type,msg,timer,id)
end)

RegisterNetEvent("cdtrent:notifstoreveh")
AddEventHandler("cdtrent:notifstoreveh", function ()
    local type = "rentsuccess"
    local msg = tr[Options.language]["storevehok"]
    local timer = 4500
    local id = "storevehok"
    Notifs(type,msg,timer,id)
end)