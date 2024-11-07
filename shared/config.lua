
-------------------------------------------------------------------
--- CDT Dev Fivem -------------------------------------------------
--- If you have any questions, you can join my discord :
--- https://dicord.gg/ae2jAmtQsm
-------------------------------------------------------------------

Options = {}

-------------------------------------------------------------------
--- Currency
-------------------------------------------------------------------
Options.currency = "$"      -- Currency label
-------------------------------------------------------------------
--- Language
-------------------------------------------------------------------
Options.language = "fr"     -- "fr" "en" "de" you can add another one in translate.lua file
-------------------------------------------------------------------
--- Blips
-------------------------------------------------------------------
Options.blip = {
    label = "Location Véhicules",   -- Blip Label
    type = 560,                     -- https://wiki.rage.mp/index.php?title=Blips     
    color = 30,                     -- Blip Color
    scale = 0.8                     -- Blip Scale
}
-------------------------------------------------------------------
--- Menu
-------------------------------------------------------------------
Options.TitleMenu = "Location"      -- Label Title Menu Rent

Options.keylabel = "[E]"            -- Key Label to open the Menu (show in DrawText)
Options.keycode = 38                -- https://docs.fivem.net/docs/game-references/controls/

-------------------------------------------------------------------
--- Rent Points
-------------------------------------------------------------------
Options.peds = {
    [1] = {
        ["text"] = "Location Véhicules",        -- Label shown in DrawText
        ["textstore"] = "Ranger Véhicule",      -- Label shown in DrawText to store the vehicle
        ["modelped"] = "s_m_m_fiboffice_02",    -- ped models : https://docs.fivem.net/docs/game-references/ped-models/
        ["coords"] = {x = -295.832978, y = -986.043946, z = 31.065918, w = 65.196854}, -- coords where then pan spawn, w : heading
        -------------------------------------------------------------------
        --- Animation / Scenario
        -------------------------------------------------------------------
        --- if you want to use scenario, leave "anim" and "dict" empty
        --- if you want to use animation, use "amin" and "dict", leave "scenario" empty
        ["anim"] = "",                          -- animation name
        ["dict"] = "",                          -- animation disctionnary
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD", -- scenario name
        -------------------------------------------------------------------
        --- Cars available in this Point
        -------------------------------------------------------------------
        --- imgPath, by default it's the docs fivem path, you can use your own images, to put them in /html/img folder
        --- if you do this, modify imgPath to : "../html/img/"
        --- images must have the spawn name of the vehicle
        ["cars"] = {
            {model = "panto", label ="Panto", price = 500, imgPath="https://docs.fivem.net/vehicles/"}, 
            {model = "issi3", label = "Issi", price = 500, imgPath="https://docs.fivem.net/vehicles/"},
            {model = "faggio2", label = "Faggio", price = 500, imgPath="https://docs.fivem.net/vehicles/"},
        },
        -------------------------------------------------------------------
        --- Spawn Point of Vehicles
        -------------------------------------------------------------------
        --- w : heading of the vehicle when he spawn
        ["coordsspawn"] = {x = -299.828582, y = -980.874756, z = 31.065918, w = 249.4488},
    },
    [2] = {
        ["text"] = "Location Véhicules",
        ["textstore"] = "Ranger Véhicule",
        ["modelped"] = "a_m_m_farmer_01",
        ["coords"] = {x = 1779.731812, y = 3310.905518, z = 41.293824, w = 317.480316},
        ["anim"] = "",
        ["dict"] = "",
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD",
        ["cars"] = {
            {model = "panto", label ="Panto", price = 500, imgPath="https://docs.fivem.net/vehicles/"},
            {model = "issi3", label = "Issi", price = 500,  imgPath="https://docs.fivem.net/vehicles/"},
            {model = "faggio2", label = "Faggio", price = 500,  imgPath="https://docs.fivem.net/vehicles/"},
        },
        ["coordsspawn"] = {x = 1774.325318, y = 3307.608886, z = 41.192626, w = 272.125976}, 
    },
    [3] = {
        ["text"] = "Location Véhicules",
        ["textstore"] = "Ranger Véhicule",
        ["modelped"] = "a_m_m_farmer_01",
        ["coords"] = {x = 141.929672, y = 6613.001954, z = 32.060058, w = 215.433074}, 
        ["anim"] = "",
        ["dict"] = "",
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD",
        ["cars"] = {
            {model = "panto", label ="Panto", price = 500, imgPath="https://docs.fivem.net/vehicles/"},
            {model = "issi3", label = "Issi", price = 500,  imgPath="https://docs.fivem.net/vehicles/"},
            {model = "faggio2", label = "Faggio", price = 500,  imgPath="https://docs.fivem.net/vehicles/"},
        },
        ["coordsspawn"] = {x = 143.103302, y = 6625.028808, z = 31.706176, w = 133.228348}, 
    },
}
-------------------------------------------------------------------
--- Plate Generation
-------------------------------------------------------------------
Options.plateLetters = "LOC"        -- "LLL" or number of characters | if you use a number, Letters will be generate by the script
Options.plateNumbers = 5            -- number | the numbers of the plate will be generate by the script
-------------------------------------------------------------------
--- Store vehicle 
-------------------------------------------------------------------
Options.storeveh = true         -- true | false
-------------------------------------------------------------------
--- Themes
-------------------------------------------------------------------
Options.theme = "Green"          -- "Blue" / "Orange" / "White" / "Red" / "Green"
-------------------------------------------------------------------
--- Notification Functions
-------------------------------------------------------------------
Notifs = function (type,msg,timer,id)
    -- use here your own export function for notification
    -- you can modify variables etc.
    exports['cdt-notifs']:showNotification(type,msg,timer,id)
end


-------------------------------------------------------------------
--- If you have any questions, you can join my discord :
--- https://dicord.gg/ae2jAmtQsm
-------------------------------------------------------------------