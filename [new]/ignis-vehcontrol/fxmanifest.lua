fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Ignis-Scripts'
description 'Vehicle Control System v1.0'
version '1.0.0'


escrow_ignore {
    'config.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

dependency '/assetpacks'