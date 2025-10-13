local sitting = false
local sitCam = nil

-- QB Target
if config.qb_target then
    exports['qb-target']:AddTargetModel(config.chairs, {
		options = {
			{	
				-- Sit
				label = config.targetName, icon = config.targetIcon,
				canInteract = function() if not sitting then return true else return false end end,
	        	action = function(entity) return sit(entity) end
			},
			{	
				-- Sit
				label = 'Sit Upright', icon = config.targetIcon,
				canInteract = function() if not sitting then return true else return false end end,
	        	action = function(entity) return sit_upright(entity) end
			},
            {
				-- Stand up
				label = config.targetNameStandUp, icon = config.targetIcon,
				canInteract = function() if sitting then return true else return false end end,
	        	action = function(entity) return ExecuteCommand('neveradev:sit:stand_up') end
			}
		},
		distance = 1.5,
	})
end

-- OX Target
if config.ox_target then
	local options =
	{
	    {
	    	-- Sit
	        label = config.targetName, name = "nvsit", icon = config.targetIcon, iconColor = "orange", distance = 1.5,
	        canInteract = function() if not sitting then return true else return false end end,
	        onSelect = function(data) 
	        	return sit(data.entity, data.coords)
	        end
	    },
        {
	    	-- Stand Up
	        label = config.targetNameStandUp, name = "nvstandup", icon = config.targetIcon, iconColor = "orange", distance = 1.5,
	        canInteract = function() if sitting then return true else return false end end,
	        onSelect = function(data) return ExecuteCommand('neveradev:sit:stand_up') end
	    }
	}
	exports.ox_target:addModel(config.chairs, options)
end

function sit(entity)
	local playerPed = PlayerPedId()
    if not DoesEntityExist(entity) then return end

    local entityCoords = GetEntityCoords(entity)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local height = math.abs(max.z - min.z)

    -- เลือกจุดนั่ง: ถอยหลังจากเก้าอี้เล็กน้อย และยก Z ประมาณครึ่งความสูงของโมเดลที่นั่ง
    -- offset local: x=0.0, y=-0.25 (ถอยหลังจากด้านหน้าเก้าอี้), z = ระดับที่น่าจะเป็นที่นั่ง
    local seatZLocal = min.z + math.min(height * 0.5, 0.55) -- clamp เล็กน้อยกันสูงเกิน
    local seatPos = GetOffsetFromEntityInWorldCoords(entity, 0.0, -0.05, seatZLocal)

    local name = GetEntityArchetypeName(entity)
	print(name)
    local heading = GetEntityHeading(entity) + 180.0
    if name == "prop_table_01_chr_b" then
        heading = heading + 90.0
    end

	if name == "v_ret_gc_chair01" then
        seatPos = vector3(
            seatPos.x - 0.15,
            seatPos.y - 0.15,
            seatPos.z + 0.37
        )
    end

	local fwd = GetEntityForwardVector(entity)
	local right = vector3(-fwd.y, fwd.x, 0.0)
	if name == "ba_prop_int_edgy_stool" then
		heading = heading + 90.0
        seatPos = vector3(
            seatPos.x + 0.0,
            seatPos.y + 0.15,
            seatPos.z + 0.37
        )
    end
	if name == "prop_bar_stool_01" then
		-- heading = heading + 90.0
        seatPos = vector3(
            seatPos.x + 0.0,
            seatPos.y + 0.0,
            seatPos.z + 0.37
        )
    end
    -- Oldie
	if name == "prop_clown_chair" then
        print(heading)
		print(heading - 180.0)
        local headingSit = heading - 180.0
        if headingSit > 35 and headingSit < 60 then
			seatPos = vector3(
				seatPos.x + (fwd.x * 0.0),
				seatPos.y + (fwd.y * 0.5),
				seatPos.z + 0.0
			)
		elseif headingSit > 60 and headingSit < 75 then
			seatPos = vector3(
				seatPos.x + (fwd.x * 0.3),
				seatPos.y + (fwd.y * 1),
				seatPos.z + 0.0
			)
		elseif headingSit > 130 and headingSit < 200 then
			seatPos = vector3(
				seatPos.x + (fwd.x * 0.3),
				seatPos.y + (fwd.y * 1),
				seatPos.z + 0.0
			)
		elseif headingSit > 200 and headingSit < 220 then
			seatPos = vector3(
				seatPos.x,
				seatPos.y + (fwd.y * 0.5),
				seatPos.z + 0.0
			)
		elseif headingSit > 220 and headingSit < 300 then
			seatPos = vector3(
				seatPos.x + (fwd.x * 0.3),
				seatPos.y + (fwd.y * 1),
				seatPos.z + 0.0
			)
		elseif headingSit > 300 and headingSit < 360 then
			seatPos = vector3(
				seatPos.x + (fwd.x * 1),
				seatPos.y + (fwd.y * 0.3),
				seatPos.z + 0.0
			)
		end    

    end
    
    if name == "as_rex_diner_barstool" then
		heading = heading - 90.0
        seatPos = vector3(
            seatPos.x + 0.0,
            seatPos.y + 0.0,
            seatPos.z + 0.37
        )
    end

    TaskStartScenarioAtPosition(playerPed, "PROP_HUMAN_SEAT_BENCH", seatPos.x, seatPos.y, seatPos.z, heading, 0, true, true)
    sitting = true


    local prevCam = GetFollowPedCamViewMode()
    CreateThread(function()
        while sitting do
            DisableFirstPersonCamThisFrame()
            if GetFollowPedCamViewMode() == 4 then
                SetFollowPedCamViewMode(1)
            end
            Wait(0)
        end
        if prevCam and prevCam ~= 4 then
            SetFollowPedCamViewMode(prevCam)
        else
            SetFollowPedCamViewMode(1)
        end
    end)

    CreateThread(function()
        local tries = 0
        while sitting and tries < 12 and IsEntityTouchingEntity(playerPed, entity) do
            local p = GetEntityCoords(playerPed)
            SetEntityCoordsNoOffset(playerPed, p.x - fwd.x * 0.02, p.y - fwd.y * 0.02, p.z, true, true, true)
            tries += 1
            Wait(0)
        end
    end)
end

function sit_upright(entity)
	local playerPed = PlayerPedId()
    if not DoesEntityExist(entity) then return end

    local entityCoords = GetEntityCoords(entity)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local height = math.abs(max.z - min.z)

    -- เลือกจุดนั่ง: ถอยหลังจากเก้าอี้เล็กน้อย และยก Z ประมาณครึ่งความสูงของโมเดลที่นั่ง
    -- offset local: x=0.0, y=-0.25 (ถอยหลังจากด้านหน้าเก้าอี้), z = ระดับที่น่าจะเป็นที่นั่ง
    local seatZLocal = min.z + math.min(height * 0.5, 0.55) -- clamp เล็กน้อยกันสูงเกิน
    local seatPos = GetOffsetFromEntityInWorldCoords(entity, 0.0, -0.05, seatZLocal)

    local name = GetEntityArchetypeName(entity)
	print(name)
    local heading = GetEntityHeading(entity) + 180.0
    if name == "prop_table_01_chr_b" then
        heading = heading + 90.0
    end

    TaskStartScenarioAtPosition(playerPed, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", seatPos.x, seatPos.y, seatPos.z, heading, 0, true, true)
    sitting = true


    local prevCam = GetFollowPedCamViewMode()
    CreateThread(function()
        while sitting do
            DisableFirstPersonCamThisFrame()
            if GetFollowPedCamViewMode() == 4 then
                SetFollowPedCamViewMode(1)
            end
            Wait(0)
        end
        if prevCam and prevCam ~= 4 then
            SetFollowPedCamViewMode(prevCam)
        else
            SetFollowPedCamViewMode(1)
        end
    end)

    CreateThread(function()
        local tries = 0
        while sitting and tries < 12 and IsEntityTouchingEntity(playerPed, entity) do
            local p = GetEntityCoords(playerPed)
            SetEntityCoordsNoOffset(playerPed, p.x - fwd.x * 0.02, p.y - fwd.y * 0.02, p.z, true, true, true)
            tries += 1
            Wait(0)
        end
    end)
end

RegisterKeyMapping('neveradev:sit:stand_up_x', 'Nevera - Stand Up X', 'keyboard', "X")
RegisterKeyMapping('neveradev:sit:stand_up_space', 'Nevera - Stand Up SPACE', 'keyboard', "SPACE")

RegisterCommand('neveradev:sit:stand_up_x', function() ExecuteCommand('neveradev:sit:stand_up') end)
RegisterCommand('neveradev:sit:stand_up_space', function() ExecuteCommand('neveradev:sit:stand_up') end)

RegisterCommand('neveradev:sit:stand_up', function()
    if sitting then
        sitting = false
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_IDLE", 0, true)
        if localEntity and DoesEntityExist(localEntity) then
            FreezeEntityPosition(localEntity, false)
        end
        if attachedEntity ~= nil then
            DetachEntity(playerPed, true, false)
            attachedEntity = nil
        end
    end
end)

local function startSitCam(ped)
    if DoesCamExist(sitCam) then DestroyCam(sitCam, false) end
    sitCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    -- ปรับ offset ตามต้องการ: y ลบ = ถอยหลัง, z = สูงขึ้น
    AttachCamToEntity(sitCam, ped, 0.0, -1.35, 0.65, true)
    SetCamFov(sitCam, 60.0)
    PointCamAtEntity(sitCam, ped, 0.0, 0.0, 0.45, true)
    RenderScriptCams(true, true, 300, true, true)
end

local function stopSitCam()
    if DoesCamExist(sitCam) then
        RenderScriptCams(false, true, 300, true, true)
        DestroyCam(sitCam, false)
        sitCam = nil
    end
end

-- ...existing code...
local registeredChairTargets = {}

local function isLikelyChair(entity)
    if not DoesEntityExist(entity) then return false end
    if GetEntityType(entity) ~= 3 then return false end -- 3 = object
    local model = GetEntityModel(entity)
    if not model or model == 0 then return false end
    local min, max = GetModelDimensions(model)
    if not min or not max then return false end
    local sx = math.abs(max.x - min.x)
    local sy = math.abs(max.y - min.y)
    local sz = math.abs(max.z - min.z)

    -- Heuristic: เก้าอี้/สตูล ขนาดประมาณนี้ (ปรับได้ตามต้องการ)
    local okX = sx >= 0.3 and sx <= 1.2
    local okY = sy >= 0.3 and sy <= 1.2
    local okZ = sz >= 0.3 and sz <= 1.5

    return okX and okY and okZ
end

-- สร้าง options สำหรับ qb-target ให้ใช้ร่วมกัน
local function buildQbOptions()
    return {
        {
            label = config.targetName, icon = config.targetIcon,
            canInteract = function(entity) return not sitting end,
            action = function(entity) return sit(entity) end
        },
        {
        label = config.targetNameStandUp, icon = config.targetIcon,
        canInteract = function(entity) return sitting end,
        action = function(entity) return ExecuteCommand('neveradev:sit:stand_up') end
    }
    }
end

-- สแกนวัตถุรอบผู้เล่นและ AddTargetEntity ให้สิ่งที่น่าจะเป็นเก้าอี้
CreateThread(function()
    while true do
        Wait(1500)
        if not config.qb_target then goto continue end

        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        local objects = GetGamePool('CObject')

        for _, obj in ipairs(objects) do
            if not registeredChairTargets[obj] and DoesEntityExist(obj) then
                local ocoords = GetEntityCoords(obj)
                if #(ocoords - pcoords) <= 5.0 and isLikelyChair(obj) then
                    exports['qb-target']:AddTargetEntity(obj, {
                        options = buildQbOptions(),
                        distance = 1.5,
                    })
                    registeredChairTargets[obj] = true
                end
            end
        end

        ::continue::
    end
end)
-- ...existing code...