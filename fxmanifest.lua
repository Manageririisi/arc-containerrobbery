fx_version 'cerulean'
game 'gta5'

author 'manageri_riisi'
description 'Konttiryöstö'
version '1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

files {
    'locales/*.json'
}

server_script 'sv_main.lua'

client_script 'cl_main.lua'

lua54 'yes'

escrow_ignore {
    'config.lua',
    'locales/*.json'
}