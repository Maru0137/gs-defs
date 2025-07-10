function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('japanese')
end

function job_setup()
    state.Buff['トリプルショット'] = buffactive['トリプルショット'] or false

    -- gs c cycle OffenseMode
    state.OffenseMode:options('Normal')

    -- gs c cycle IdleMode
    state.IdleMode:options('Normal')

    -- gs c cycle WeaponskillMode
    state.WeaponskillMode:options('Normal', 'Accuracy', 'SubtleBlow')

    -- gs c cycle MainWeapons
    state.MainWeapons = M { 'Naegling', 'RostamA', 'RostamC', 'OnionSword2', 'Kustawi', 'Malevolence', 'Tauret' }

    -- gs c cycle SubWeapons
    state.SubWeapons = M { 'GletisKnife', 'Tauret', 'Kustawi', 'NusukuShield' }

    -- gs c cycle RangeWeapons
    state.RangeWeapons = M { 'Ataktos', 'DeathPenalty', 'Fomalhaut' }

    state.CorsairRollMode = M { ['description'] = 'Corsair\'s Roll Mode', 'Normal', 'NoTPReset', 'Short' }

    state.LuzafRing = M(true, 'Enable Luzaf\'s Ring')
end
