local QBCore = exports['qb-core']:GetCoreObject()
local attached_weapons = {}
local hotbar = {}
local sling = "Front"
local playerLoaded = true

-- Keep hotbar in sync with inventory (slots 1-5 and optional 41)
local function RefreshHotbar(items)
	hotbar = {}
	local inv = items or (QBCore.Functions.GetPlayerData() or {}).items or {}
	for _, invItem in pairs(inv) do
		if invItem and invItem.slot then
			if invItem.slot >= 1 and invItem.slot <= 5 then
				hotbar[invItem.slot] = invItem
			elseif invItem.slot == 41 then
				hotbar[41] = invItem
			end
		end
	end
end

-- Choose only one weapon to sling (priority: 1->5, then 41), skip the one in hands
local orderedSlots = {1, 2, 3, 4, 5, 41}
local function GetSlingCandidate(me)
	local selected = GetSelectedPedWeapon(me)
	for _, slot in ipairs(orderedSlots) do
		local it = hotbar[slot]
		if it and it.type == "weapon" then
			local cfg = Config.compatable_weapon_hashes[it.name]
			if cfg and cfg.model and cfg.hash and selected ~= cfg.hash then
				return cfg -- { model=..., hash=... }
			end
		end
	end
	return nil
end

Citizen.CreateThread(function()
	while true do
		if playerLoaded then
			local me = PlayerPedId()
			RefreshHotbar()

			-- Attach only one weapon based on priority, detach all others
			local candidate = GetSlingCandidate(me)

			-- Detach everything that is not the candidate
			for key, attached_object in pairs(attached_weapons) do
				if (not candidate) or attached_object.hash ~= candidate.hash then
					if DoesEntityExist(attached_object.handle) then
						DeleteObject(attached_object.handle)
					end
					attached_weapons[key] = nil
				end
			end

			-- Attach candidate if not already attached
			if candidate and not attached_weapons[candidate.model] then
				local pos = Config.Positions[sling]
				if pos then
					AttachWeapon(candidate.model, candidate.hash, pos.bone, pos.x, pos.y, pos.z, pos.x_rotation, pos.y_rotation, pos.z_rotation)
				end
			end
		end
		Wait(500)
	end
end)

function inHotbar(hash)
	for slot, it in pairs(hotbar) do
		if it and it.type == "weapon" then
			local cfg = Config.compatable_weapon_hashes[it.name]
			if cfg and hash == cfg.hash then
				return true
			end
		end
	end
	return false
end

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
	local mhash = GetHashKey(attachModel)
	if not IsModelInCdimage(mhash) or not IsModelValid(mhash) then
		-- print(("Invalid model: %s"):format(tostring(attachModel)))
		return
	end

	RequestModel(mhash)
	while not HasModelLoaded(mhash) do
		Wait(50)
	end

	attached_weapons[attachModel] = {
		hash = modelHash,
		handle = CreateObject(mhash, 1.0, 1.0, 1.0, true, true, false)
	}

	AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(mhash)
end

-- Events to manage player state and inventory updates
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	playerLoaded = true
	RefreshHotbar()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	playerLoaded = false
	RefreshHotbar({})
	for k, obj in pairs(attached_weapons) do
		if DoesEntityExist(obj.handle) then DeleteObject(obj.handle) end
		attached_weapons[k] = nil
	end
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
	if data and data.items then
		RefreshHotbar(data.items)
	end
end)
