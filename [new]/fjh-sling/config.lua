Config = {}

-- Weapon attach positions
Config.Positions = {
	Front = {
		bone = 10706, -- pelvis
		x = 0.0, y = 0.19, z = -0.25,
		x_rotation = 0.0, y_rotation = 75.0, z_rotation = 180.0
        },
}

-- Map inventory item names to world models and weapon hashes
    Config.compatable_weapon_hashes = {
	["weapon_pistol"] = {
		model = "w_pi_pistol",
		hash = GetHashKey("WEAPON_PISTOL")
	},
	["weapon_combatpistol"] = {
		model = "w_pi_combatpistol",
		hash = GetHashKey("WEAPON_COMBATPISTOL")
	},
	["weapon_carbinerifle"] = {
		model = "w_ar_carbinerifle",
		hash = GetHashKey("WEAPON_CARBINERIFLE")
	},
	["weapon_smg"] = {
		model = "w_sb_smg",
		hash = GetHashKey("WEAPON_SMG")
	},
	["weapon_carbinerifle_mk2"] = {
		model = "w_ar_carbineriflemk2",
		hash = GetHashKey("weapon_carbinerifle_mk2")
	},
	["weapon_assaultrifle"] = {
		model = "w_ar_assaultrifle",
		hash = GetHashKey("weapon_assaultrifle")
	},
	["weapon_specialcarbine"] = {
		model = "w_ar_specialcarbine",
		hash = GetHashKey("weapon_specialcarbine")
	},
	["weapon_bullpuprifle"] = {
		model = "w_ar_bullpuprifle",
		hash = GetHashKey("weapon_bullpuprifle")
	},
	["weapon_advancedrifle"] = {
		model = "w_ar_advancedrifle",
		hash = GetHashKey("weapon_advancedrifle")
	},
	["weapon_microsmg"] = {
		model = "w_sb_microsmg",
		hash = GetHashKey("weapon_microsmg")
	},
	["weapon_assaultsmg"] = {
		model = "w_sb_assaultsmg",
		hash = GetHashKey("weapon_assaultsmg")
	},
	["weapon_gusenberg"] = {
		model = "w_sb_gusenberg",
		hash = GetHashKey("weapon_gusenberg")
	},
	["weapon_sniperrifle"] = {
		model = "w_sr_sniperrifle",
		hash = GetHashKey("weapon_sniperrifle")
	},
	["weapon_assaultshotgun"] = {
		model = "w_sg_assaultshotgun",
		hash = GetHashKey("weapon_assaultshotgun")
	},
	["weapon_bullpupshotgun"] = {
		model = "w_sg_bullpupshotgun",
		hash = GetHashKey("weapon_bullpupshotgun")
	},
	["weapon_pumpshotgun"] = {
		model = "w_sg_pumpshotgun",
		hash = GetHashKey("weapon_pumpshotgun")
	},
	["weapon_musket"] = {
		model = "w_ar_musket",
		hash = GetHashKey("weapon_musket")
	},
	["weapon_heavyshotgun"] = {
		model = "w_sg_heavyshotgun",
		hash = GetHashKey("weapon_heavyshotgun")
	},
}
