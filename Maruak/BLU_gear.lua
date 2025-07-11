function init_weapons()
    --デフォルト武器を設定
    send_command('gs c set MainWeapons Naegling')
    send_command('gs c set SubWeapons SakpatasSword')
end

function init_gear_sets()
    -- Lockstyle
    lockstyleset = 61

    -- Ambuscade Mantles
    gear.AmbusMantle.FC = { name = "ロスメルタケープ", augments = { 'AGI+20', 'Eva.+20 /Mag. Eva.+20', '"Fast Cast"+10', 'Damage taken-5%', } }
    gear.AmbusMantle.AASTP = { name = "ロスメルタケープ", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSSTR = { name = "ロスメルタケープ", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-2%', } }
    gear.AmbusMantle.MG = { name = "ロスメルタケープ", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Damage taken-5%', } }
    gear.AmbusMantle.MGAcc = { name = "ロスメルタケープ", augments = { 'MP+60', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Phys. dmg. taken-10%', } }

    -- Raive Mantles
    gear.RaiveMantle = { name = "コンフラワーケープ", augments = { 'MP+28', 'DEX+3', 'Accuracy+3', 'Blue Magic skill +9', } }

    -- Sortie Earring
    gear.SortieEarring = { name = "ハシシンピアス+1", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+15', 'Mag. Acc.+15', '"Dbl.Atk."+5', } }

    -- sets
    --- Idle sets
    sets.idle = {
        ammo = "ストンチタスラム+1",
        head = "無の面",
        body = "ＨＳミンタン+3",
        hands = "マリグナスグローブ",
        legs = "マリグナスタイツ",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "バーシチョーカー+1", augments = { 'Path: A', } },
        waist = "無の腰当",
        left_ear = "エアバニピアス",
        right_ear = "インフューズピアス",
        left_ring = "シュネデックリング",
        right_ring = "フォテファイリング",
        back = gear.AmbusMantle.FC
    }

    --- Kiting
    sets.Kiting = { left_ring = "シュネデックリング", }

    --- Engaged Sets
    sets.engaged = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = "マリグナスシャポー",
        body = "マリグナスタバード",
        hands = "マリグナスグローブ",
        legs = "マリグナスタイツ",
        feet = "マリグナスブーツ",
        neck = { name = "ミラージストール+1", augments = { 'Path: A', } },
        waist = "霊亀腰帯",
        left_ear = "エアバニピアス",
        right_ear = "テロスピアス",
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AASTP
    }

    --- Defence Sets
    sets.defense.PDT = {
        ammo = "ストンチタスラム+1",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = "アダマンアーマー",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "アンムーヴカラー+1", augments = { 'Path: A', } },
        waist = "カシリベルト",
        left_ear = { name = "オノワイヤリング+1", augments = { 'Path: A', } },
        right_ear = "無知の耳",
        left_ring = { name = "ゼラチナスリング+1", augments = { 'Path: A', } },
        right_ring = "フォテファイリング",
        back = gear.AmbusMantle.FC
    }

    sets.defense.MDT = {
        ammo = "サピエンスオーブ",
        head = "ＨＳカヴク+3",
        body = "アダマンアーマー",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = "ＨＳミンタン+3",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "ウォーダチャーム+1", augments = { 'Path: A', } },
        waist = "カシリベルト",
        left_ear = "エアバニピアス+1",
        right_ear = "無知の耳",
        left_ring = "ヴェクサーリング+1",
        right_ring = "ヴェクサーリング+1",
        back = gear.AmbusMantle.FC
    }

    -- Fast Cast Sets
    sets.precast.FC = {
        ammo = "ストンチタスラム+1",
        head = { name = "カマインマスク+1", augments = { 'Accuracy+20', 'Mag. Acc.+12', '"Fast Cast"+4', } },
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "ピンガズボン",
        feet = { name = "カマイングリーヴ+1", augments = { 'HP+80', 'MP+80', 'Phys. dmg. taken -4', } },
        neck = { name = "ロリケートトルク+1", augments = { 'Path: A', } },
        waist = "無の腰当",
        left_ear = "エアバニピアス",
        right_ear = "ロケイシャスピアス",
        left_ring = "キシャールリング",
        right_ring = "守りの指輪",
        back = gear.AmbusMantle.FC,
    }

    --監視用バフ
    -- TODO

    -- Abillities

    -- WeapinSkills
    sets.precast.WS.melee = {
        ammo = "オシャシャの原論文",
        head = "ＨＳカヴク+3",
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "共和プラチナ章",
        waist = { name = "セールフィベルト+1", augments = { 'Path: A' } },
        left_ear = "イシュヴァラピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "スローダリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_critical = sets.precast.WS.melee

    sets.precast.WS.melee_multi = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "ミラージストール+1", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = "イラブラットリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_debuf = {
        ammo = "ペムフレドタスラム",
        head = "ＨＳカヴク+3",
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "ＨＳタイト+3",
        feet = "ＨＳバシュマク+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
        back = "無の外装"
    }

    sets.precast.WS.melee_accuracy = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = "ＨＳカヴク+3",
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "ＨＳタイト+3",
        feet = "ＨＳバシュマク+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = "ディグニタリピアス",
        right_ear = gear.SortieEarring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = "無の外装"
    }

    sets.precast.WS.magical = {
        ammo = { name = "ガストリタスラム+1", augments = { 'Path: A', } },
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "ベーテルペンダント",
        waist = gear.ElementalObiOrOrpheus,
        left_ear = "フリオミシピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "エパミノダスリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.subtleblow = sets.precast.SubtleBlow

    --共通WS定義読み込み
    set_default_ws_sets()

    -- 個別WS定義
    sets.precast.WS["シャンデュシニュ"].Normal = set_combine(sets.precast.WS.melee_multi, {
        head = { name = "ブリスタサリット+1", augments = { 'Path: A', } },
        neck = { name = "ミラージストール+1", augments = { 'Path: A', } },
        waist = "フォシャベルト",
        left_ear = "オドルピアス",
        right_ear = gear.SortieEarring,
    })
    sets.precast.WS["レクイエスカット"].Normal = set_combine(sets.precast.WS.melee_multi, {
        neck = "フォシャゴルゲット",
        waist = "フォシャベルト",
        left_ear = "ブルタルピアス",
        right_ear = gear.MoonshadeEarring,
    })
    sets.precast.WS["サンギンブレード"].Normal = set_combine(sets.precast.WS.magical, {
        head = "妖蟲の髪飾り+1",
        right_ring = "アルコンリング",
    })


    -- Blue Magic Sets
    sets.midcast.BlueMagical = {
        ammo = { name = "ガストリタスラム+1", augments = { 'Path: A', } },
        head = "ＨＳカヴク+3",
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "ＨＳタイト+3",
        feet = "ＨＳバシュマク+3",
        neck = "シビルスカーフ",
        waist = gear.ElementalObiOrOrpheus,
        left_ear = "フリオミシピアス",
        right_ear = "王将の耳飾り",
        left_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
        right_ring = "女王の指輪+1",
        back = gear.AmbusMantle.MG
    }

    sets.midcast["エントゥーム"] = set_combine(sets.midcast.BlueMagical, {
        neck = "クアンプネックレス",
        right_ring = { name = "ゼラチナスリング+1", augments = { 'Path: A', } },
    })

    sets.midcast["アンビルライトニング"] = set_combine(sets.midcast.BlueMagical, {
        right_ring = "イラブラットリング",
    })

    sets.midcast["テネブラルクラッシュ"] = set_combine(sets.midcast.BlueMagical, {
        head = "妖蟲の髪飾り+1",
        right_ring = "アルコンリング",
    })

    sets.midcast.BlueMagicAcc = {
        ammo = "ペムフレドタスラム",
        head = "ＨＳカヴク+3",
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "ＨＳタイト+3",
        feet = "ＨＳバシュマク+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = "ディグニタリピアス",
        right_ear = gear.SortieEarring,
        left_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
        right_ring = "スティキニリング+1",
        back = gear.AmbusMantle.MGAcc
    }

    sets.midcast.BlueBuff = {
        ammo = "ペムフレドタスラム",
        head = "ＨＳカヴク+3",
        body = "ＨＳミンタン+3",
        hands = "ＨＳバズバンド+3",
        legs = "マリグナスタイツ",
        feet = "ＬＬチャルク+2",
        neck = "レチペンダント",
        waist = "ギシドゥバサッシュ",
        left_ear = "カラミタスピアス",
        eight_ear = "磁界の耳",
        left_ring = { name = "メフィタスリング+1", augments = { 'Path: A', } },
        right_ring = "守りの指輪",
        back = gear.AmbusMantle.FC
    }

    sets.midcast.BlueHead = sets.midcast.BlueMagical
end
