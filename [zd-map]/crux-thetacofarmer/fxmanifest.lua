fx_version 'cerulean'
game 'gta5'
lua54 'yes'

this_is_a_map 'yes'

author 'Crux Studio'
description 'The Taco Farmer MLO'
version '1.0.0'

files {
    'interiorproxies.meta',
    'stream/*.ydr',
    'stream/*.ybn',
    'stream/*.ytyp',
    'stream/*.ymap',
    'stream/*.ymf',
    'stream/*.ytd',
    'audio/iconic_taco_door_audio_game.dat151.rel',
}

dependencies {
    'crux-thetacofarmer',  -- Do not edit this
}

data_file 'AUDIO_GAMEDATA' 'audio/iconic_taco_door_audio_game.dat'

escrow_ignore {
    'stream/**/*.ytd'
}
dependency '/assetpacks'