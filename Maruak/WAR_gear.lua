function init_weapons()
    --デフォルト武器を設定
    send_command('gs c set MainWeapons Naegling')
    send_command('gs c set SubWeapons BlurredShield')
end

function init_gear_sets()
    -- Lockstyle
    lockstyleset = 61

    -- Ambuscade Mantles
    gear.AmbusMantle.AADA = { name = "シコルマント", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSSTR = { name = "シコルマント", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSVIT = { name = "シコルマント", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }

    -- Raive Mantles

    -- Sortie Earring
    gear.SortieEarring = { name = "ボイイピアス+1", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+13', 'Mag. Acc.+13', 'Crit.hit rate+4', } }

    -- sets
    --- Idle sets
    sets.idle = {
        ammo = "ストンチタスラム+1",
        head = "無の面",
        body = "ＢＩロリカ+3",
        hands = { name = "サクパタガントレ", augments = { 'Path: A', } },
        legs = "ＢＩクウィス+3",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = "上級近衛騎士カラー",
        waist = "無の腰当",
        left_ear = { name = "ズワゾピアス+1", augments = { 'Path: A', } },
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
        head = "ＢＩマスク+3",
        body = "ＢＩロリカ+3",
        hands = { name = "サクパタガントレ", augments = { 'Path: A', } },
        legs = "ＢＩクウィス+3",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = "イオスケハベルト+1",
        left_ear = { name = "シェレピアス", augments = { 'Path: A', } },
        right_ear = gear.SortieEarring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADA
    }

    sets.engaged['Laphria'] = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = { name = "サクパタヘルム", augments = { 'Path: A', } },
        body = "ＢＩロリカ+3",
        hands = { name = "サクパタガントレ", augments = { 'Path: A', } },
        legs = "ＡＧクウィス+4",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = "イオスケハベルト+1",
        left_ear = { name = "シェレピアス", augments = { 'Path: A', } },
        right_ear = gear.SortieEarring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADA
    }


    --- Defence Sets
    sets.defense.PDT = {
        ammo = "ストンチタスラム+1",
        head = "ＢＩマスク+3",
        body = "アダマンアーマー",
        hands = "ＡＧマフラ+3",
        legs = "サクパタクウィス",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = "上級近衛騎士カラー",
        waist = "イオスケハベルト+1",
        left_ear = { name = "ズワゾピアス+1", augments = { 'Path: A', } },
        right_ear = "スリオスイヤリング",
        left_ring = "シーリチリング+1",
        right_ring = "フォテファイリング",
        back = gear.AmbusMantle.AADA
    }

    sets.defense.MDT = {
        ammo = "ストンチタスラム+1",
        head = { name = "サクパタヘルム", augments = { 'Path: A', } },
        body = "アダマンアーマー",
        hands = { name = "サクパタガントレ", augments = { 'Path: A', } },
        legs = "サクパタクウィス",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = { name = "ウォーダチャーム+1", augments = { 'Path: A', } },
        waist = "イオスケハベルト+1",
        left_ear = "エアバニピアス+1",
        right_ear = { name = "オノワイヤリング+1", augments = { 'Path: A', } },
        left_ring = "ヴェクサーリング+1",
        right_ring = "ヴェクサーリング+1",
        back = gear.AmbusMantle.AADA
    }

    -- Fast Cast Sets
    sets.precast.FC = set_combine(sets.precast.FC, {
        head = { name = "サクパタヘルム", augments = { 'Path: A', } },
        body = "サクロブレスト",
    })

    --監視用バフ
    -- TODO

    -- Abillities
    sets.precast.JA['マイティストライク'] = { hands = "ＡＧマフラ+3" }
    sets.precast.JA['バーサク'] = { body = "ＰＭロリカ+2", feet = "ＡＧカリガ+3", back = "シコルマント" }
    sets.precast.JA['ディフェンダー'] = { hands = "ＡＧマフラ+3" }
    sets.precast.JA['ウォークライ'] = { head = "ＡＧマスク+4" }
    sets.precast.JA['アグレッサー'] = { body = "アゴージロリカ" }
    sets.precast.JA['トマホーク'] = { ammo = "Ｔ．トマホーク", feet = "ＡＧカリガ+3" }
    sets.precast.JA['ブラッドレイジ'] = { body = "ＢＩロリカ+3" }

    -- WeapinSkills
    sets.precast.WS.melee = {
        ammo = "ノブキエリ",
        head = "ＡＧマスク+4",
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = "ＢＩマフラ+3",
        legs = "ＢＩクウィス+3",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A' } },
        left_ear = gear.MoonshadeEarring,
        right_ear = "スラッドピアス",
        left_ring = "コーネリアリング",
        right_ring = "王将の指輪",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_critical = {
        ammo = "イェットシーラ+1",
        head = "ＡＧマスク+4",
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = "ＢＩマフラ+3",
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = gear.MoonshadeEarring,
        right_ear = "スラッドピアス",
        left_ring = "コーネリアリング",
        right_ring = "王将の指輪",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_multi = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = "ニックマドゥリング",
        back = gear.AmbusMantle.AADA
    }

    sets.precast.WS.melee_debuf = {
        ammo = "ペムフレドタスラム",
        head = "ＢＩマスク+3",
        body = "ＢＩロリカ+3",
        hands = "ＢＩマフラ+3",
        legs = "ＢＩクウィス+3",
        feet = "ＢＩカリガ+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
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
        waist = gear.ElementalObiOrOrpheus,
        left_ear = gear.MoonshadeEarring,
        right_ear = "フリオミシピアス",
        left_ring = "コーネリアリング",
        right_ring = "エパミノダスリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.subtleblow = set_combine(
        sets.precast.WS.melee,
        sets.precast.SubtleBlow, {
            left_ear = { name = "シェレピアス", augments = { 'Path: A', } },
            right_ear = gear.SortieEarring,
        })

    --共通WS定義読み込み
    set_default_ws_sets()

    -- 個別WS定義
    sets.precast.WS["アップヒーバル"].Normal = set_combine(sets.precast.WS.melee, { back = gear.AmbusMantle.WSVIT })
end
