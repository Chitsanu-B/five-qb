CreateThread(function()
    local restaurants = {
        {coords = vector3(-1542.56, -416.01, 35.64), name = "UwU Cafe"},
        {coords = vector3(459.66, 139.45, 99.43), name = "Deer Diner"},
        {coords = vector3(-535.93, -53.45, 42.42), name = "Oldie"},
        {coords = vector3(2539.3, 2586.87, 38.5), name = "Rex Diner"},
        {coords = vector3(896.38, -1039.68, 35.24), name = "Antique Bar"},
        {coords = vector3(15.82, -1602.83, 29.39), name = "TACO FARMER"},
    }

    for _, v in ipairs(restaurants) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)  -- แยก x,y,z
        SetBlipSprite(blip, 417)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 48)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end

    local superMarket = {
        {coords = vector3(2004.49, 3783.33, 32.18), name = "Supermarket"},
        {coords = vector3(162.73, 6640.57, 31.7), name = "Supermarket"},
        {coords = vector3(2543.23, 2639.1, 37.95), name = "Supermarket"},
    }

    for _, v in ipairs(superMarket) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)  -- แยก x,y,z
        SetBlipSprite(blip, 59)          -- ไอคอนร้านค้า
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)           -- เขียว
        SetBlipAsShortRange(blip, true) -- ให้เห็นบนแผนที่เสมอ
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end

    local keyShop = {
        {coords = vector3(158.01, 6654.11, 31.67), name = "Key Shop"},
        {coords = vector3(171.1715, -1798.1793, 29.1891), name = "Key Shop"},
    }

    for _, v in ipairs(keyShop) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)  -- แยก x,y,z
        SetBlipSprite(blip, 811)          -- ไอคอนร้านค้า
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 0)           
        SetBlipAsShortRange(blip, true) -- ให้เห็นบนแผนที่เสมอ
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end
end)

