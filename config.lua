--[[
    rsg-loading : config.lua

    Seasonal themes. This file is read directly by the loading screen
    (html/script.js), so keep it to plain values: strings, numbers,
    booleans and tables. No functions or logic.

    Dates use the PLAYER'S local clock, format 'MM-DD'.
    A range may wrap the new year, e.g. start '12-01', finish '01-06'.
]]

Config = {}

-- 'auto'      = pick the theme whose date window contains today
-- 'default'   = never use a seasonal theme
-- 'easter' / 'halloween' / 'christmas' = force that theme all year (handy for testing)
Config.Theme = 'auto'

-- Particle effects (snow, bats, petals). Set false to disable on all themes.
Config.Particles = true

Config.Themes = {

    easter = {
        enabled  = true,
        -- Easter moves every year, so it is calculated automatically.
        -- The theme shows from X days before Easter Sunday until Y days after.
        easterDaysBefore = 7,
        easterDaysAfter  = 1,

        subtitle   = 'H A P P Y  E A S T E R',
        seal       = '✿',
        divider    = '❀',
        particles  = 'petals',
        background = 'images/easter.jpeg',   -- path inside html/ (or a URL). Blank = keep the normal background
        backgroundDim = 0.35,                -- 0 = full brightness, 1 = black
        colors = {
            accent   = '#f4c7e0',
            accent2  = '#c9e7b8',
            border   = '#8a6f86',
            panel    = '#1d1820',
            panel2   = '#2a2230',
            text     = '#fff8fc',
            muted    = '#c8b6c6',
        },
        tips = {
            'Tip: Keep your eyes peeled for hidden eggs around Valentine.',
            'Tip: Spring has sprung on the frontier.',
        },
    },

    halloween = {
        enabled = true,
        start   = '10-15',
        finish  = '11-01',

        subtitle   = 'T H E  D E A D  R I D E  T O N I G H T',
        seal       = '☠',
        divider    = '✝',
        particles  = 'bats',
        background = 'images/halloween.jpeg',   -- path inside html/ (or a URL). Blank = keep the normal background
        backgroundDim = 0.35,                -- 0 = full brightness, 1 = black
        colors = {
            accent   = '#ff7a1a',
            accent2  = '#ffb347',
            border   = '#7a3d12',
            panel    = '#120a06',
            panel2   = '#1f120a',
            text     = '#fff1e6',
            muted    = '#c59a7c',
        },
        tips = {
            'Tip: Something stirs in the swamps of Lemoyne after dark...',
            'Tip: Never ride alone on All Hallows Eve.',
        },
    },

    christmas = {
        enabled = true,
        start   = '12-01',
        finish  = '12-31',

        subtitle   = 'M E R R Y  C H R I S T M A S',
        seal       = '❄',
        divider    = '✦',
        particles  = 'snow',
        background = 'images/christmas.jpeg',   -- path inside html/ (or a URL). Blank = keep the normal background
        backgroundDim = 0.35,                -- 0 = full brightness, 1 = black
        colors = {
            accent   = '#e8f4ff',
            accent2  = '#c0392b',
            border   = '#5c7d6a',
            panel    = '#0b1410',
            panel2   = '#13241b',
            text     = '#ffffff',
            muted    = '#a9c4b5',
        },
        tips = {
            'Tip: Wrap up warm, the mountains are freezing this time of year.',
            'Tip: Merry Christmas from all the staff!',
        },
    },
}

-- When true, seasonal tips are added to your normal tips. When false they replace them.
Config.MergeTips = true
