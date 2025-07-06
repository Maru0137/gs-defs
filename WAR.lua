function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('japanese')
end

function job_setup()
    state.Buff['マイティストライク'] = buffactive['マイティストライク'] or false
    state.Buff['バーサク'] = buffactive['バーサク'] or false
    state.Buff['ディフェンダー'] = buffactive['ディフェンダー'] or false
    state.Buff['ウォークライ'] = buffactive['ウォークライ'] or false
    state.Buff['リタリエーション'] = buffactive['リタリエーション'] or false
    state.Buff['ウォーリアーチャージ'] = buffactive['ウォーリアーチャージ'] or false
    state.Buff['リストレント'] = buffactive['リストレント'] or false
    state.Buff['ブラッドレイジ'] = buffactive['ブラッドレイジ'] or false
    state.Buff['ブラーゼンラッシュ'] = buffactive['ブラーゼンラッシュ'] or false

    -- gs c cycle OffenseMode
    state.OffenseMode:options('Normal')

    -- gs c cycle IdleMode
    state.IdleMode:options('Normal')

    -- gs c cycle WeaponskillMode
    state.WeaponskillMode:options('Normal', 'Accuracy', 'SubtleBlow')

    -- gs c cycle MainWeapons
    state.MainWeapons = M { 'Laphria', 'Chango', 'Lycurgos', 'ShiningOne', 'Naegling', 'LoxoticMace', 'IkengasAxe', 'Malevolence' }

    -- gs c cycle SubWeapons
    state.SubWeapons  = M { 'UtuGrip', 'BlurredShield', 'AdapaShield' }
end
