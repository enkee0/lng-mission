Config = {}

Config.MissionPed = 'g_m_y_famfor_01'
-- do not do the Config.Mission true
Config.Mission = false

Config.Items = {
    [1] = 'weapon_snspistol',
    [2] = 'weapon_snspistol_mk2',
    [3] = 'weapon_pistol_mk2'
}

Config.SearchingBlip = {
    {
        name = "Searching Area",
        coord = vector3(1949.1, 4986.82, 42.97),
        radius = 500.0,
        
        showBlip = true
    },
}

Config.BagLocation = {
    [1] =  { ['x'] = 1917.84, ['y'] = 4963.77, ['z'] = 48.14,},
    [2] =  { ['x'] = 1804.06, ['y'] = 4937.3, ['z'] = 43.84,},
    [3] =  { ['x'] = 2018.63, ['y'] = 4997.75, ['z'] = 40.87,},
    [4] =  { ['x'] = 2211.32, ['y'] = 4680.25, ['z'] = 34.0,},
}

Config.MoneyAmount = 25000