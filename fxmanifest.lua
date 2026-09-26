fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

name 'rsg-loading'
author 'RexShack'
description 'RSG RedM Loading Screen'
version '2.0.0'

loadscreen 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/locales/en.json',
    'html/config.json',
    'html/images/*'
}

loadscreen_manual_shutdown 'yes'
