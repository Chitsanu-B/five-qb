fx_version 'cerulean'
description 'A script to control the MOTEL interiors DoItDigital.'
version '1.0'
games { 'gta5' }

lua54 'on'

client_scripts {
    "client.lua",
    "config.lua"
}

escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'