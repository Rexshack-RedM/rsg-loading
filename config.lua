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
-- 'easter' / 'halloween' / 'christmas' = force that holiday theme all year (handy for testing)
-- 'winter' / 'spring' / 'summer' / 'autumn' = force that season theme all year
Config.Theme = 'auto'

-- Particle effects (snow, bats, petals, leaves, fireflies). Set false to disable on all themes.
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

--[[
    Season themes. In 'auto' mode, when no holiday theme above is active,
    the season theme whose window contains today is used instead.
    Set Config.UseSeasons = false to fall back to your normal look.
    Windows default to UK meteorological seasons. Same options as the holiday themes.
]]
Config.UseSeasons = true

Config.Seasons = {

    winter = {
        enabled = true,
        start   = '12-01',
        finish  = '02-28',       -- wraps the new year (Feb 29 also counts)

        subtitle      = 'T H E  C O L D  W E S T',
        seal          = '❄',
        divider       = '✦',
        particles     = 'snow',
        background    = 'images/winter.jpeg',
        backgroundDim = 0.4,
        colors = {
            accent  = '#cfe3f5',
            accent2 = '#ffffff',
            border  = '#5d6f82',
            panel   = '#0d1218',
            panel2  = '#18212b',
            text    = '#f4f8fc',
            muted   = '#a3b4c4',
        },
        tips = {
            'Tip: Dress warmly before heading into the mountains.',
        },
    },

    spring = {
        enabled = true,
        start   = '03-01',
        finish  = '05-31',

        subtitle      = 'A  N E W  S E A S O N',
        seal          = '❀',
        divider       = '✿',
        particles     = 'petals',
        background    = 'images/spring.jpeg',
        backgroundDim = 0.4,
        colors = {
            accent  = '#9ed67a',
            accent2 = '#ffe98a',
            border  = '#4f6e40',
            panel   = '#0e150c',
            panel2  = '#182414',
            text    = '#f6fff0',
            muted   = '#aec6a2',
        },
        tips = {
            'Tip: Spring rains bring the best hunting on the plains.',
        },
    },

    summer = {
        enabled = true,
        start   = '06-01',
        finish  = '08-31',

        subtitle      = 'S U N  S C O R C H E D  F R O N T I E R',
        seal          = '☀',
        divider       = '✦',
        particles     = 'fireflies',
        background    = 'images/summer.jpeg',
        backgroundDim = 0.4,
        colors = {
            accent  = '#ffb347',
            accent2 = '#ffe08a',
            border  = '#8a5a2e',
            panel   = '#160e07',
            panel2  = '#24170b',
            text    = '#fff6e8',
            muted   = '#cfae8a',
        },
        tips = {
            'Tip: Carry plenty of water when crossing the desert.',
        },
    },

    autumn = {
        enabled = true,
        start   = '09-01',
        finish  = '11-30',

        subtitle      = 'T H E  L E A V E S  A R E  F A L L I N G',
        seal          = '❦',
        divider       = '✦',
        particles     = 'leaves',
        background    = 'images/autumn.jpeg',
        backgroundDim = 0.4,
        colors = {
            accent  = '#e0782a',
            accent2 = '#f2c14e',
            border  = '#7a4a22',
            panel   = '#140c06',
            panel2  = '#22140a',
            text    = '#fff3e6',
            muted   = '#c9a585',
        },
        tips = {
            'Tip: Stock up on supplies before winter sets in.',
        },
    },
}
