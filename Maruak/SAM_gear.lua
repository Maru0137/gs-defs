function init_weapons()
    --デフォルト武器を設定
    send_command('gs c set MainWeapons Dojikiri')
    send_command('gs c set SubWeapons UtuGrip')
end

function init_gear_sets()
    -- Lockstyle
    lockstyleset = 61

    -- Ambuscade Mantles
    gear.AmbusMantle.AADA = { name = "スメルトリオマント", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSSTR = { name = "スメルトリオマント", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }

    -- Raive Mantles

    -- Sortie Earring
    -- TODO: Check and fix
    gear.SortieEarring = { name = "春日耳飾り+1", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+13', 'Mag. Acc.+13', 'Crit.hit rate+4', } }

    -- Sets
    --- Idle sets
    sets.idle = {
        ammo = "ストンチタスラム+1",
        head = "無の面",
        body = "サクロブレスト",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = "極春日板佩楯",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "上級近衛騎士カラー",
        waist = "無の腰当",
        left_ear = "エアバニピアス",
        right_ear = "インフューズピアス",
        left_ring = "シュネデックリング",
        right_ring = "ローラーリング",
        back = gear.AmbusMantle.AADA
    }

    --- Kiting
    sets.Kiting = { left_ring = "シュネデックリング", }

    --- Engaged Sets
    sets.engaged = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = "極春日烏帽子形兜",
        body = "極春日胴丸",
        hands = { name = "楯無篭手改", augments = { 'Path: A', } },
        legs = "極春日板佩楯",
        feet = { name = "楯無脛当", augments = { 'Path: A', } },
        neck = "月光の喉輪",
        waist = "イオスケハベルト+1",
        left_ear = { name = "シェレピアス", augments = { 'Path: A', } },
        right_ear = "ディグニタリピアス",
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADA
    }

    --- Defence Sets
    sets.defense.PDT = {
        ammo = "ストンチタスラム+1",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = "アダマンアーマー",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "上級近衛騎士カラー",
        waist = "イオスケハベルト+1",
        left_ear = "エアバニピアス",
        right_ear = { name = "オノワイヤリング+1", augments = { 'Path: A', } },
        left_ring = { name = "ゼラチナスリング+1", augments = { 'Path: A', } },
        right_ring = "フォテファイリング",
        back = gear.AmbusMantle.AADA
    }

    sets.defense.MDT = sets.defense.PDT

    -- Fast Cast Sets
    sets.precast.FC = set_combine(sets.precast.FC, {
        body = "サクロブレスト",
    })

    --監視用バフ
    -- TODO

    -- Abillities
    sets.precast.JA['護摩の守護円'] = { head = "真脇戸桃形兜" }
    sets.precast.JA['黙想'] = { head = "真脇戸桃形兜", back = gear.AmbusMantle.AADA }

    -- WeapinSkills
    sets.precast.WS.melee = {
        ammo = "ノブキエリ",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = "極春日筒篭手",
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "共和プラチナ章",
        waist = { name = "セールフィベルト+1", augments = { 'Path: A' } },
        left_ear = gear.MoonshadeEarring,
        right_ear = "スラッドピアス",
        left_ring = "コーネリアリング",
        right_ring = "王将の指輪",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_critical = set_combine(sets.precast.WS.melee, {
        left_ear = "スラッドピアス",
        right_ear = gear.SortieEarring
    })

    sets.precast.WS.melee_multi = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "フォシャゴルゲット",
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = gear.MoonshadeEarring,
        right_ear = "ブルタルピアス",
        left_ring = "コーネリアリング",
        right_ring = "ニックマドゥリング",
        back = gear.AmbusMantle.AADA
    }

    sets.precast.WS.melee_debuf = {
        ammo = "ペムフレドタスラム",
        head = "極春日烏帽子形兜",
        body = "極春日胴丸",
        hands = "極春日筒篭手",
        legs = "極春日板佩楯",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
        right_ring = "スティキニリング+1",
        back = "無の外装"
    }

    sets.precast.WS.melee_accuracy = {
        ammo = { name = "シーズボムレット+1", augments = { 'Path: A', } },
        head = "ＢＩマスク+3",
        body = "ＢＩロリカ+3",
        hands = "ＢＩマフラ+3",
        legs = "ＢＩクウィス+3",
        feet = "ＢＩカリガ+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = "ディグニタリピアス",
        right_ear = gear.SortieEarring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = "無の外装"
    }

    sets.precast.WS.magical = {
        ammo = "ノブキエリ",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "ベーテルペンダント",
        waist = "オルペウスサッシュ",
        left_ear = gear.MoonshadeEarring,
        right_ear = "フリオミシピアス",
        left_ring = "コーネリアリング",
        right_ring = "エパミノダスリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.hybrid_melee = {
        ammo = "ノブキエリ",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "フォシャゴルゲット",
        waist = "オルペウスサッシュ",
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = "エパミノダスリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, {
        left_ear = { name = "シェレピアス", augments = { 'Path: A', } }
    })

    set_default_ws_sets()

    -- Custom Weapon Skill Sets
end
