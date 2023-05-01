--------------------------------------------------
------------- JOIN OUR DISCORD SERVER ------------
--------- https://discord.gg/7gbCD9Fzct ----------
--------------------------------------------------
--------------- DEVELOPED BY FLAP ----------------
-------------------- WITH 💜 ---------------------
--------------------------------------------------

fx_version 'adamant'
game 'gta5'
author 'Flap'
description 'Hud by Flap'
version '1.0'

ui_page 'html/index.html'

shared_scripts {
	'@es_extended/imports.lua',
}

client_scripts {
	'config/config.lua',
	'client/client.lua'
}
server_scripts {
	'config/config.lua',
	'server/server.lua',
	'config/server_config.lua'
}

files {
	'html/index.html',
	'html/main.js',
	'html/main.css'
}

dependencies {
	'es_extended'
}