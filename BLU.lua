function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('japanese')
end

function job_setup()
    state.Buff['ブルーバースト'] = buffactive['ブルーバースト'] or false
    state.Buff['ブルーチェーン'] = buffactive['ブルーチェーン'] or false
    state.Buff['ディフュージョン'] = buffactive['ディフュージョン'] or false
    state.Buff['エフラックス'] = buffactive['エフラックス'] or false

    -- gs c cycle OffenseMode
    state.OffenseMode:options('Normal')

    -- gs c cycle IdleMode
    state.IdleMode:options('Normal')

    -- gs c cycle WeaponskillMode
    state.WeaponskillMode:options('Normal', 'Accuracy', 'SubtleBlow')

    -- gs c cycle MainWeapons
    state.MainWeapons = M { 'Naegling', 'SakpatasSword', 'OnionSword2', 'Maxentius' }

    -- gs c cycle SubWeapons
    state.SubWeapons  = M { 'SakpatasSword', 'Machaera', 'BunzisRod' }
end
