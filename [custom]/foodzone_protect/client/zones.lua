local foodZone = nil

-- เพิ่มฟังก์ชันแจ้งเตือนแบบพื้นฐาน (ไม่ต้องพึ่ง ESX/QBCore)
local function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, true)
end

CreateThread(function()
    local boxZone = BoxZone:Create(vector3(-536.64, -52.77, 42.42), 11.8, 24.0, {
        name = "oldie-bar-zone",
        heading = 335,
        debugPoly = false, -- เปิดเพื่อดูเส้นขอบโซน (false เมื่อใช้งานจริง)
        minZ = 40.0,
        maxZ = 45.0
    })

    boxZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            TriggerServerEvent('player:freezeNeeds', true)
             notify("TEST MESSAGE IN", 'primary')
        else
            TriggerServerEvent('player:freezeNeeds', false)
             notify("TEST MESSAGE OUT", 'primary')
        end
    end)
end)