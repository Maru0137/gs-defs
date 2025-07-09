function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('japanese')
end

function job_setup()
    state.Buff['明鏡止水'] = buffactive['明鏡止水'] or false
    state.Buff['護摩の守護円'] = buffactive['護摩の守護円'] or false
    state.Buff['心眼'] = buffactive['心眼'] or false
    state.Buff['八双'] = buffactive['八双'] or false
    state.Buff['星眼'] = buffactive['星眼'] or false
    state.Buff['石火之機'] = buffactive['石火之機'] or false
    state.Buff['渾然一体'] = buffactive['渾然一体'] or false
    state.Buff['先義後利'] = buffactive['先義後利'] or false
    state.Buff['破魔の刃'] = buffactive['破魔の刃'] or false
    state.Buff['葉隠'] = buffactive['葉隠'] or false
    state.Buff['八重霞'] = buffactive['八重霞'] or false

    -- gs c cycle OffenseMode
    state.OffenseMode:options('Normal')

    -- gs c cycle IdleMode
    state.IdleMode:options('Normal')

    -- gs c cycle WeaponskillMode
    state.WeaponskillMode:options('Normal', 'Accuracy', 'SubtleBlow')

    -- gs c cycle MainWeapons
    state.MainWeapons = M { 'Dojikiri' }

    -- gs c cycle SubWeapons
    state.SubWeapons  = M { 'UtuGrip' }
end
