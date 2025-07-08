function init_weaponns()
    --デフォルト武器を設定
    send_command('gs c set MainWeapons Naegling')
    send_command('gs c set SubWeapons BlurredShield')
end

function init_gear_sets()
    --ロックスタイル番号
    lockstyleset = 61

    --武器
    gear.Laphria = { name = "ラフリア" }
    gear.Chango = { name = "シャンゴル", auguments = { 'Path: A', } }
    gear.Lycurgos = { name = "ライカーゴス" }
    gear.ShiningOne = { name = "シャイニングワン" }
    gear.Naegling = { name = "ネイグリング" }
    gear.LoxoticMace = { name = "ロクソテクメイス+1", augments = { 'Path: A', } }
    gear.IkengasAxe = { name = "イケンガアクス", auguments = { 'Path: A', } }
    gear.Malevolence = { name = "マレヴォレンス", augments = { 'Path: A', } }
    gear.UtuGrip = { name = "ウトゥグリップ" }
    gear.BlurredShield = { name = "ブラーシールド+1" }
    gear.AdapaShield = { name = "アダパシールド" }

    -- AmbusMantles
    gear.AmbusMantle.AADA = { name = "シコルマント", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSSTR = { name = "シコルマント", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.AmbusMantle.WSVIT = { name = "シコルマント", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }

    -- SortieEaring
    gear.SortieEaring = { name = "ボイイピアス+1", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+13', 'Mag. Acc.+13', 'Crit.hit rate+4', } }

    --待機装備
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

    --走り回る用
    sets.Kiting = { left_ring = "シュネデックリング", }

    --抜刀装備
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
        right_ear = gear.SortieEaring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADA
    }

    sets.engaged.PDT = {
        ammo = { name = "コイストボダー", augments = { 'Path: A', } },
        head = "ＢＩマスク+3",
        body = "アダマンアーマー",
        hands = "ＡＧマフラ+3",
        legs = "サクパタクウィス",
        feet = { name = "サクパタレギンス", augments = { 'Path: A', } },
        neck = "上級近衛騎士カラー",
        waist = "イオスケハベルト+1",
        left_ear = { name = "ズワゾピアス+1", augments = { 'Path: A', } },
        right_ear = "スリオスイヤリング",
        left_ring = "フォテファイリング",
        right_ring = "シーリチリング+1",
        back = gear.AmbusMantle.AADA
    }

    --監視用バフ
    -- TODO

    --即時発動系
    sets.precast.JA['マイティストライク'] = { hand = "ＡＧマフラ+3" }
    sets.precast.JA['バーサク'] = { body = "ＰＭロリカ+2", feet = "ＡＧカリガ+3", back = "シコルマント" }
    sets.precast.JA['ディフェンダー'] = { hand = "ＡＧマフラ+3" }
    sets.precast.JA['ウォークライ'] = { head = "ＡＧマスク+4" }
    sets.precast.JA['トマホーク'] = { feet = "ＡＧカリガ+3" }
    sets.precast.JA['ブラッドレイジ'] = { body = "ＢＩロリカ+3" }

    --FC
    -- TODO

    --WSダメージ
    sets.precast.WS.melee = {
        ammo = "ノブキエリ",
        head = "ＡＧマスク+4",
        body = { name = "ニャメメイル", augments = { 'Path: B', } },
        hands = "ＢＩマフラ+3",
        legs = "ＢＩクウィス+3",
        feet = { name = "ニャメソルレット", augments = { 'Path: B', } },
        neck = { name = "戦士の数珠+2", augments = { 'Path: A', } },
        waist = { name = "セールフィベルト+1", augments = { 'Path: A' } },
        left_ear = gear.MoonshadeEaring,
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
        left_ear = gear.MoonshadeEaring,
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
        left_ear = gear.MoonshadeEaring,
        right_ear = gear.SortieEaring,
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
        left_ear = gear.MoonshadeEaring,
        right_ear = gear.SortieEaring,
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
        right_ear = gear.SortieEaring,
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
        left_ear = gear.MoonshadeEaring,
        right_ear = "フリオミシピアス",
        left_ring = "コーネリアリング",
        right_ring = "エパミノダスリング",
        back = gear.AmbusMantle.WSSTR
    }

    sets.precast.WS.subtleblow = {
        neck = { name = "バーシチョーカー+1", augments = { 'Path: A', } },
        waist = "ニヌルタサッシュ",
        right_ear = gear.SortieEaring,
        left_ring = "シーリチリング+1",
        right_ring = "シーリチリング+1",
    }
    -- T

    --共通WS定義読み込み
    init_weapon_skill()

    -- 個別WS定義
    sets.precast.WS["アップヒーバル"].Normal = set_combine(sets.precast.WS.melee, { back = gear.AmbusMantle.WSVIT })
end
