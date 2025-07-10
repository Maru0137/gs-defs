function init_weapons()
    --デフォルト武器を設定
    send_command('gs c set MainWeapons Naegling')
    send_command('gs c set SubWeapons BlurredShield')
end

function init_gear_sets()
    -- Lockstyle
    lockstyleset = 61

    -- Ambuscade Mantles
    -- TODO
    gear.AmbusMantle.Snap = {}
    gear.AmbusMantle.AADW = { name = "カムラスマント", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.RA = {}
    gear.AmbusMantle.WSSTR = { name = "カムラスマント", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSDEXDA = {}
    gear.AmbusMantle.WSAGIPhys = {}
    gear.AmbusMantle.WSAGIElem = {}
    gear.AmbusMantle.MGAcc = {}

    -- Raive Mantles
    -- TODO
    gear.RaiveMantle = {}

    -- Sortie Earring
    -- TODO
    gear.SortieEarring = {}

    -- sets
    --- Idle sets
    sets.idle = {
        head = "無の面",
        body = "マリグナスタバード",
        hands = "マリグナスグローブ",
        legs = "ＣＳトルーズ+3",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "バーシチョーカー+1", augments = { 'Path: A', } },
        waist = "無の腰当",
        left_ear = "エアバニピアス",
        right_ear = "インフューズピアス",
        left_ring = "シュネデックリング",
        right_ring = "ローラーリング",
        back = gear.AmbusMantle.Snap
    }

    --- Kiting
    sets.Kiting = { left_ring = "シュネデックリング", }

    --- Engaged Sets
    sets.engaged = {
        head = "マリグナスシャポー",
        body = "マリグナスタバード",
        hands = "マリグナスグローブ",
        legs = "ＣＳトルーズ+3",
        feet = "マリグナスブーツ",
        neck = { name = "バーシチョーカー+1", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = "テロスピアス",
        right_ear = "ディグニタリピアス",
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADW
    }

    --- Defence Sets
    sets.defense.PDT = {
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = "アダマンアーマー",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "上級近衛騎士カラー",
        waist = "プラチナモグベルト",
        left_ear = "トゥイストピアス",
        right_ear = { name = "オノワイヤリング+1", augments = { 'Path: A', } },
        left_ring = { name = "ゼラチナスリング+1", augments = { 'Path: A', } },
        right_ring = "フォテファイリング",
        back = gear.AmbusMantle.AADW
    }

    sets.defense.MDT = sets.defense.PDT

    -- Fast Cast Sets
    -- TODO

    -- Range Attack Sets
    sets.precast.RA = {
        ammo = "クロノブレット",
        head = { name = "イケンガハット", augments = { 'Path: A', } },
        body = { name = "イケンガベスト", augments = { 'Path: A', } },
        hands = { name = "カマインフィンガ+1", augments = { 'Path: D', } },
        legs = "ＣＳトルーズ+3",
        feet = "メガナダジャンボ+2",
        neck = { name = "コモドアチャーム+1", augments = { 'Path: A', } },
        waist = "インパルスベルト",
        left_ring = "昏黄の指輪",
        right_ring = "守りの指輪",
        back = gear.AmbusMantle.Snap
    }

    sets.midcast.RA = {
        ammo = "クロノブレット",
        head = { name = "イケンガハット", augments = { 'Path: A', } },
        body = { name = "イケンガベスト", augments = { 'Path: A', } },
        hands = "マリグナスグローブ",
        legs = "ＣＳトルーズ+3",
        feet = "マリグナスブーツ",
        neck = "イスクルゴルゲット",
        waist = { name = "テレンベルト", augments = { 'Path: A', } },
        left_ear = "昏黄の耳飾り",
        right_ear = "テロスピアス",
        left_ring = "昏黄の指輪",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.RA
    }

    --監視用バフ
    -- TODO

    -- Abillities
    sets.precast.JA['ワイルドカード'] = { feet = "ＬＡブーツ+4" }
    sets.precast.JA['ランダムディール'] = { hands = "ＬＡフラック+3" }

    ---- Corsair's Roll
    local CorsairRollSetsBase = {
        main = gear.RostamC,
        head = "無の面",
        body = "ＣＳフラック+3",
        hands = "ニャメガントレ",
        -- TODO: Fix
        legs = { name = "デサルタタセッツ", augments = { '"Phantom Roll" ability delay -5' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B' } },
        neck = "無の喉輪",
        waist = "プラチナモグベルト",
        left_ear = { name = "オノワイヤリング+1", augments = { 'Path: A' } },
        right_ear = gear.SortieEarring,
        left_ring = "シュネデックリング",
        right_ring = "守りの指輪",
        back = gear.RaiveMantle
    }

    sets.precasr.CorsairRoll['ボルターズロール'].Short = CorsairRollSetsBase
    sets.precast.CorsairRoll['ナチュラリストロール'].Short = CorsairRollSetsBase
    sets.precast.CorsairRoll.Short = set_combine(CorsairRollSetsBase, { head = "ＬＡトリコルヌ+2" })

    local CorsairRollDurSets = {
        hands = "ＣＳガントリー+3",
        neck = "王将の首飾り",
        back = gear.AmbusMantle.Snap
    }

    sets.precast.CorsairRoll.NoTPReset = set_combine(sets.precast.CorsairRoll.Short, CorsairRollDurSets)
    sets.precast.CorsairRoll.Normal = set_combine(sets.precast.CorsairRoll.NoTPReset, {
        range = gear.Compensator
    })

    -- WeapinSkills
    sets.precast.WS.melee = {
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "共和プラチナ章",
        waist = { name = "セールフィベルト+1", augments = { 'Path: A' } },
        left_ear = "イシュヴァラピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "王将の指輪",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.melee_critical = sets.precast.WS.melee

    sets.precast.WS.melee_multi = {
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B' } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "共和プラチナ章",
        waist = { name = "セールフィベルト+1", augments = { 'Path: A', } },
        left_ear = "ブルタルピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "王将の指輪",
        back = gear.AmbusMantle.WSDEXDA
    }

    sets.precast.WS.melee_debuf = {
        head = "マリグナスシャポー",
        body = "ＣＳタバード+3",
        hands = "ＣＳガントリー+3",
        legs = "ＣＳトルーズ+3",
        feet = "ＣＳブーツ+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = gear.MoonshadeEarring,
        right_ear = gear.SortieEarring,
        left_ring = { name = "メタモルリング+1", augments = { 'Path: A', } },
        right_ring = "スティキニリング+1",
        back = "無の外装"
    }

    sets.precast.WS.melee_accuracy = {
        head = "マリグナスシャポー",
        body = "ＣＳタバード+3",
        hands = "ＣＳガントリー+3",
        legs = "ＣＳトルーズ+3",
        feet = "ＣＳブーツ+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = "ディグニタリピアス",
        right_ear = gear.SortieEarring,
        left_ring = "コーネリアリング",
        right_ring = "シーリチリング+1",
        back = "無の外装"
    }

    sets.precast.WS.ranged = {
        ammo = "クロノブレット",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "イケンガベスト", augments = { 'Path: A', } },
        hands = "ＣＳガントリー+3",
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "イスクルゴルゲット",
        waist = { name = "テレンベルト", augments = { 'Path: A', } },
        left_ear = "テロスピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "ディンジルリング",
        back = gear.AmbusMantle.WSAGIPhys
    }

    sets.precast.WS.ranged_multi = {
        ammo = "クロノブレット",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "イケンガベスト", augments = { 'Path: A', } },
        hands = "ＣＳガントリー+3",
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = "フォシャゴルゲット",
        waist = "フォシャベルト",
        left_ear = "テロスピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "ディンジルリング",
        back = gear.AmbusMantle.WSAGIPhys
    }

    sets.precast.WS.ranged_accuracy = {
        head = "マリグナスシャポー",
        body = "ＣＳタバード+3",
        hands = "ＣＳガントリー+3",
        legs = "ＣＳトルーズ+3",
        feet = "ＣＳブーツ+3",
        neck = "無の喉輪",
        waist = "無の腰当",
        left_ear = "テロスピアス",
        right_ear = "ベイラピアス",
        left_ring = "コーネリアリング",
        right_ring = { name = "カコエシクリング+1", augments = { 'Path: A', } },
        back = "無の外装"
    }

    sets.precast.WS.magical = {
        ammo = "ライヴブレット",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = "ＬＡフラック+3",
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = "ＬＡブーツ+4",
        neck = { name = "コモドアチャーム+1", augments = { 'Path: A', } },
        waist = "オルペウスサッシュ",
        left_ear = "フリオミシピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "ディンジルリング",
        back = gear.AmbusMantle.WSAGIElem
    }

    sets.precast.WS.hybrid_ranged = {
        ammo = "クロノブレット",
        head = { name = "ニャメヘルム", augments = { 'Path: B', } },
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = { name = "ニャメガントレ", augments = { 'Path: B', } },
        legs = { name = "ニャメフランチャ", augments = { 'Path: B', } },
        feet = "ＬＡブーツ+4",
        neck = { name = "コモドアチャーム+1", augments = { 'Path: A', } },
        waist = "オルペウスサッシュ",
        left_ear = "フリオミシピアス",
        right_ear = gear.MoonshadeEarring,
        left_ring = "コーネリアリング",
        right_ring = "ディンジルリング",
        back = gear.AmbusMantle.WSAGIElem
    }

    sets.precast.WS.SubtleBlow = set_combine(
        sets.precast.WS.melee,
        sets.precast.SubtleBlow
    )

    --共通WS定義読み込み
    set_default_ws_sets()

    -- 個別WS定義
    sets.precast.WS["レデンサリュート"].Normal = set_combine(sets.precast.WS.Magical, {
        head = "妖蟲の髪飾り+1"
    })
end
