-- Common definition file for all jobs and all characters.

-- Initial setup
function user_setup()
    state.Buff['睡眠']  = buffactive['睡眠'] or false                   --監視するバフ・デバフ
    
    -- include(player.name .. '/weather_obi')                              --属性帯ロード    
    -- include('smn_avatar')                                               --召喚定義ファイルロード
    -- include('organizer-lib')
    include('ws_attr')
    include('elemental')
    define_roll_values()                                                --ロール情報   
    init_weapons()                                                      --武器初期化
    init_custom_spell_map()                                             --スペルマップ定義再構築    
    init_gears()
    init_ws_attr_map()

    send_command('input /chatmode party')                               --チャットモード変更

    include(player.name .. '/sets')
    set_user_sets()

    -- send_command('wait 4; gs c set IdleMode Normal; gs c lockstyleset;')--待機装備着替え後にロックスタイル固定
end


--■■■サブタゲ選択時の処理
function user_post_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' then
        display_roll_info(spell)
    end
end


--■■■アクション前処理（共通実装なし）
function user_post_precast(spell, action, spellMap, eventArgs)
    if is_elemental_weapon_skill(spell) and elemental_obi_is_better_than_orpheus(spell.element) then
        equip(get_elemental_obi(spell.element))
    end
end

--■■■アクション中処理
function user_post_midcast(spell, action, spellMap, eventArgs)
    if is_elemental_magic_affedted_by_whether(spell, spellMap) then
        equip(get_elemental_obi(spell.element))
    end
end


--■■■アクション後処理（共通実装なし）
function user_post_aftercast(spell, action, spellMap, eventArgs)
end


--■■■バフデバフ変更時の共通処理
function user_buff_change(buff, gain)
    if state.Buff['睡眠'] then
        equip({main=gear.Slip})
        equip({range=gear.Slip})
    elseif buff == "ファランクス" and not gain then
        windower.add_to_chat(167,'■■■ ファランクス切れ ■■■')
    elseif buff == "八双" and not gain then
        windower.add_to_chat(167,'■■■ 八双切れ ■■■')
    elseif buff == "コルア展開" and not gain then
        windower.add_to_chat(167,'■■■ インデ切れ ■■■')
    end
end


--■■■待機攻撃装備着替え処理
function user_customize_idle_set(idleSet)
    return set_combine(idleSet,user_customize_weapon_set())
end


--■■■攻撃装備着替え処理
function customize_melee_set(meleeSet)
    if(player.sub_job == '忍') then
        --二刀流係数11
        meleeSet = set_combine(meleeSet,sets.engaged.dual11)
    elseif(player.sub_job == '踊') then
        --二刀流係数21
        meleeSet = set_combine(meleeSet,sets.engaged.dual21)
    end
    return set_combine(meleeSet,user_customize_weapon_set())
end


--■■■武器変更処理
function user_customize_weapon_set()
    weapon = set_combine(weapon,{main=gear[state.MainWeapons.value]})
    weapon = set_combine(weapon,{sub=gear[state.SubWeapons.value]})
    return weapon
end


--■■■セルフコマンド
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'Idle' then                  --待機装備着替え
        Idle()
    elseif cmdParams[1] == 'Medicine' then          --状態異常回復
        Medicine()
    elseif cmdParams[1] == 'aspir' then             --アスピルマクロ節約
        Aspir()
    elseif cmdParams[1] == 'drain' then             --ドレインマクロ節約
        Drain()
    elseif cmdParams[1] == 'Enmity' then            --単体ヘイトアップ処理
        ActionEnmity()
    elseif cmdParams[1] == 'EnmityRange' then       --範囲ヘイトアップ処理
        ActionEnmityRange()
    elseif cmdParams[1] == 'lockstyleset' then      --ロックスタイル固定処理
        if player.main_job ~= '学' then
            send_command('input /lockstyleset '..lockstyleset)
        end
    end
    if type(custom_self_command) == "function" then --カスタムセルフコマンド呼び出し
        custom_self_command(cmdParams, eventArgs)
    end
end


--■■■状態異常回復
function Medicine()
    if buffactive['死の宣告'] or buffactive['呪い'] then
        send_command('input /item '..windower.to_shift_jis('聖水')..' <me>')
    elseif buffactive['バインド'] or  buffactive['ヘヴィ']  or  buffactive['スロウ']then
        send_command('input /item '..windower.to_shift_jis('パナケイア')..' <me>')
    elseif buffactive['静寂'] then
        send_command('input /item '..windower.to_shift_jis('やまびこ薬')..' <me>')
        send_command('input /item '..windower.to_shift_jis('万能薬')..' <me>')
    elseif buffactive['麻痺'] then
        send_command('input /item '..windower.to_shift_jis('万能薬')..' <me>')
    elseif buffactive['毒'] then
        send_command('input /item '..windower.to_shift_jis('毒消し')..' <me>')
        send_command('input /item '..windower.to_shift_jis('万能薬')..' <me>')
    elseif buffactive['病気'] then
        send_command('input /item '..windower.to_shift_jis('万能薬')..' <me>')
    elseif buffactive['暗闇'] then
        send_command('input /item '..windower.to_shift_jis('目薬')..' <me>')
        send_command('input /item '..windower.to_shift_jis('万能薬')..' <me>')
    end
end


--■■■待機攻撃装備着替え
function Idle()
    if player.status == 'Idle'then 
        equip(get_idle_set()) 
    else
        equip(get_melee_set()) 
    end
end


--■■■アスピルマクロ節約
function Aspir()
    local recasts = windower.ffxi.get_spell_recasts()
    local recast_time_3 = recasts[881]/60
    local recast_time_2 = recasts[248]/60
    local recast_time_1 = recasts[247]/60

    if recast_time_3 == 0 and (player.main_job == '風' or player.main_job == '黒') then
       send_command('input /magic '..windower.to_shift_jis('アスピルIII')..' <stnpc>')
    elseif recast_time_2 == 0 then
        send_command('input /magic '..windower.to_shift_jis('アスピルII')..' <stnpc>')
    elseif recast_time_1 == 0 then
        send_command('input /magic '..windower.to_shift_jis('アスピル')..' <stnpc>')
    else
        windower.add_to_chat(30, 'アスピル リキャスト---> III: %.1fs, II: %.1fs, I: %.1fs':format(recast_time_3, recast_time_1, recast_time_1))
    end
end


--■■■ドレインマクロ節約
function Drain()
    local recasts = windower.ffxi.get_spell_recasts()
    local recast_time_3 = recasts[880]/60
    local recast_time_2 = recasts[246]/60
    local recast_time_1 = recasts[245]/60

    if recast_time_3 == 0 and player.main_job == '暗' then
        send_command('input /magic '..windower.to_shift_jis('ドレインIII')..' <stnpc>')
    elseif recast_time_2 == 0 and player.main_job == '暗' then
        send_command('input /magic '..windower.to_shift_jis('ドレインII')..' <stnpc>')
    elseif recast_time_1 == 0 then
        send_command('input /magic '..windower.to_shift_jis('ドレイン')..' <stnpc>')
    else
        windower.add_to_chat(30, 'ドレイン リキャスト---> III: %.1fs,II: %.1fs, I: %.1fs':format(recast_time_3, recast_time_2, recast_time_1))
    end
end


--■■■単体ヘイトアップ処理
function ActionEnmity()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local recast_time_Flash     = spell_recasts[112]/60
    local recast_time_BlankGaze = spell_recasts[592]/60
    local recast_time_Jettatura = spell_recasts[575]/60
    local recast_time_Stun      = spell_recasts[252]/60
    local recast_time_abzotac   = spell_recasts[275]/60
    
    local ability_recasts = windower.ffxi.get_ability_recasts()
    local recast_time_Provoke = spell_recasts[5]/60

    if recast_time_Flash == 0 then
        send_command('input /ma '..windower.to_shift_jis('フラッシュ')..' <stnpc>')
    elseif player.sub_job == '青' and recast_time_Jettatura == 0 then
        send_command('input /ma '..windower.to_shift_jis('ジェタチュラ')..' <stnpc>')--0.5
    elseif player.sub_job == '青' and recast_time_BlankGaze == 0 then
        send_command('input /ma '..windower.to_shift_jis('ブランクゲイズ')..' <stnpc>')--3
    elseif player.sub_job == '戦' and recast_time_Provoke == 0 then
        send_command('input /ja '..windower.to_shift_jis('挑発')..' <stnpc>')
    elseif player.sub_job == '暗' and recast_time_Stun == 0 then
        send_command('input /ma '..windower.to_shift_jis('スタン')..' <stnpc>')
    elseif player.sub_job == '暗' and recast_time_abzotac == 0 then
        send_command('input /ma '..windower.to_shift_jis('アブゾタック')..' <stnpc>')
    end
end


--■■■範囲ヘイトアップ処理
function ActionEnmityRange()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local recast_time_FrightfulRoar = spell_recasts[561]/60
    local recast_time_Soporific = spell_recasts[598]/60
    local recast_time_SheepSong = spell_recasts[584]/60
    local recast_time_GeistWall = spell_recasts[605]/60
    local recast_time_Stinking  = spell_recasts[537]/60
    local recast_time_Poisonga  = spell_recasts[225]/60
    if player.sub_job == '青' and recast_time_FrightfulRoar == 0 and player.sub_job_level>49 then
        send_command('input /ma '..windower.to_shift_jis('フライトフルロア')..' <stnpc>')--2
    elseif player.sub_job == '青' and recast_time_GeistWall == 0 then
        send_command('input /ma '..windower.to_shift_jis('ガイストウォール')..' <stnpc>')--3
    elseif player.sub_job == '青' and recast_time_Stinking == 0 then
        send_command('input /ma '..windower.to_shift_jis('スティンキングガス')..' <stnpc>')--4
    elseif player.sub_job == '青' and recast_time_Soporific == 0 then
        send_command('input /ma '..windower.to_shift_jis('サペリフィック')..' <stnpc>')--3
    elseif player.sub_job == '青' and recast_time_SheepSong == 0 then
        send_command('input /ma '..windower.to_shift_jis('シープソング')..' <stnpc>')--3
    elseif player.sub_job == '暗' and recast_time_Poisonga == 0 then
        send_command('input /ma '..windower.to_shift_jis('ポイゾガ')..' <stnpc>')--3
    end
end


--■■■スペルマップ再構築取得用
function job_get_spell_map(spell, default_spell_map)
    local new_spell_map = default_spell_map
    if spell.type == 'BlueMagic' then
        new_spell_map = bm_spell_maps[spell.name]
    elseif spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard' then
        new_spell_map = bp_spell_maps[spell.name]
    end
    return new_spell_map
end


--■■■青魔法スペルマップ定義再構築
function init_custom_spell_map()
    bm_spell_maps = {
    	--物理系青魔法
        ['F.リップ']='BluePhysical',['H.バラージ']='BluePhysical',['M.バイト']='BluePhysical',['S.ドライバー']='BluePhysical',['T.アッサルト']='BluePhysical',['まつぼっくり爆弾']='BluePhysical',['アシュラクロー']='BluePhysical',['アッパーカット']='BluePhysical',['エンプティスラッシュ']='BluePhysical',['キャノンボール']='BluePhysical',['クアドラストライク']='BluePhysical',['グランドスラム']='BluePhysical',['グルーティナスダート']='BluePhysical',['クローサイクロン']='BluePhysical',['ゴブリンラッシュ']='BluePhysical',['サウリアンスライド']='BluePhysical',['サドンランジ']='BluePhysical',['サブゼロスマッシュ']='BluePhysical',['シードスプレー']='BluePhysical',['ジェットストリーム']='BluePhysical',['シックルスラッシュ']='BluePhysical',['シンカードリル']='BluePhysical',['スイープガウジ']='BluePhysical',['スパイナルクリーブ']='BluePhysical',['スパイラルスピン']='BluePhysical',['スプラウトスマック']='BluePhysical',['ディセバーメント']='BluePhysical',['テールスラップ']='BluePhysical',['テラータッチ']='BluePhysical',['デスシザース']='BluePhysical',['デルタスラスト']='BluePhysical',['トゥールビヨン']='BluePhysical',['ハイドロショット']='BluePhysical',['バトルダンス']='BluePhysical',['バニティダイブ']='BluePhysical',['バーチカルクリーヴ']='BluePhysical',['パラライズトライアド']='BluePhysical',['パワーアタック']='BluePhysical',['ビルジストーム']='BluePhysical',['フットキック']='BluePhysical',['フライパン']='BluePhysical',['ブラッドレイク']='BluePhysical',['ヘッドバット']='BluePhysical',['ヘルダイブ']='BluePhysical',['ベンシクタイフーン']='BluePhysical',['ボディプレス']='BluePhysical',['マヨイタケ']='BluePhysical',['メッタ打ち']='BluePhysical',['ラムチャージ']='BluePhysical',['偃月刃']='BluePhysical',['四連突']='BluePhysical',['怒りの一撃']='BluePhysical',['怒りの旋風']='BluePhysical',['槍玉']='BluePhysical',['次元殺']='BluePhysical',['種まき']='BluePhysical',['羽根吹雪']='BluePhysical',['重い一撃']='BluePhysical',['ファイナルスピア']='BluePhysical',
        --魔法系青魔法
        ['A.ライベーション']='BlueMagical',['B.シュトラール']='BlueMagical',['B.フルゴア']='BlueMagical',['D.ワールウィンド']='BlueMagical',['F.ヒッププレス']='BlueMagical',['MP吸収キッス']='BlueMagical',['R.デルージュ']='BlueMagical',['R.ブレス']='BlueMagical',['T.アップヒーヴ']='BlueMagical',['みんなの怨み']='BlueMagical',['アイズオンミー']='BlueMagical',['アイスブレイク']='BlueMagical',['アクリッドストリーム']='BlueMagical',['アップルート']='BlueMagical',['アンビルライトニング']='BlueMagical',['ウィンドブレス']='BlueMagical',['ヴェイパースプレー']='BlueMagical',['エントゥーム']='BlueMagical',['エンバームアース']='BlueMagical',['オスモーシス']='BlueMagical',['カースドスフィア']='BlueMagical',['クラッシュサンダー']='BlueMagical',['ゲーツオブハデス']='BlueMagical',['コローシブウーズ']='BlueMagical',['サイレントストーム']='BlueMagical',['サブダックション']='BlueMagical',['サンダーブレス']='BlueMagical',['サンダーボルト']='BlueMagical',['サーマルパルス']='BlueMagical',['シアリングテンペスト']='BlueMagical',['スカウリングスペイト']='BlueMagical',['スペクトラルフロー']='BlueMagical',['セスプール']='BlueMagical',['ダークオーブ']='BlueMagical',['チャージドホイスカー']='BlueMagical',['ディフュージョンレイ']='BlueMagical',['デスレイ']='BlueMagical',['テネブラルクラッシュ']='BlueMagical',['テーリングガスト']='BlueMagical',['ネクターデルージュ']='BlueMagical',['ファイアースピット']='BlueMagical',['ファウルウォーター']='BlueMagical',['ブラッドセイバー']='BlueMagical',['ブレーズバウンド']='BlueMagical',['フロストブレス']='BlueMagical',['ヘカトンウェーブ']='BlueMagical',['ポーリングサルヴォ']='BlueMagical',['ポイズンブレス']='BlueMagical',['ポラーロア']='BlueMagical',['メイルシュトロム']='BlueMagical',['マインドブラスト']='BlueMagical',['モルトプルメイジ']='BlueMagical',['リガージテーション']='BlueMagical',['リーフストーム']='BlueMagical',['レテナグレア']='BlueMagical',['レールキャノン']='BlueMagical',['吸血']='BlueMagical',['土竜巻']='BlueMagical',['水風船爆弾']='BlueMagical',['消化']='BlueMagical',['火炎の息']='BlueMagical',['炸裂弾']='BlueMagical',['爆弾投げ']='BlueMagical',['磁鉄粉']='BlueMagical',['神秘の光']='BlueMagical',['自爆']='BlueMagical',['臭い息']='BlueMagical',['針千本']='BlueMagical',
        --弱体系青魔法
        ['A.バースト']='BlueMagicAcc',['C.ディスチャージ']='BlueMagicAcc',['D.ロア']='BlueMagicAcc',['F.ホールド']='BlueMagicAcc',['アーフルアイ']='BlueMagicAcc',['アブソルートテラー']='BlueMagicAcc',['オーロラルドレープ']='BlueMagicAcc',['カオティックアイ']='BlueMagicAcc',['クルエルジョーク']='BlueMagicAcc',['ガイストウォール']='BlueMagicAcc',['コールドウェーブ']='BlueMagicAcc',['サウンドブラスト']='BlueMagicAcc',['サペリフィック']='BlueMagicAcc',['サンドスプレー']='BlueMagicAcc',['シープソング']='BlueMagicAcc',['ジェタチュラ']='BlueMagicAcc',['スティンキングガス']='BlueMagicAcc',['テンポラルシフト']='BlueMagicAcc',['フェザーティックル']='BlueMagicAcc',['フライトフルロア']='BlueMagicAcc',['ブランクゲイズ']='BlueMagicAcc',['ベノムシェル']='BlueMagicAcc',['ブリスターローア']='BlueMagicAcc',['モータルレイ']='BlueMagicAcc',['ヤーン']='BlueMagicAcc',['リービンウィンド']='BlueMagicAcc',['ロウイン']='BlueMagicAcc',['夢想花']='BlueMagicAcc',['吶喊']='BlueMagicAcc',['吸印']='BlueMagicAcc',['贖罪の光']='BlueMagicAcc',['超低周波']='BlueMagicAcc',
        --回復系青魔法	
        ['いやしの風']='BlueHealing',['マジックフルーツ']='BlueHealing',['P.エンブレイス']='BlueHealing',['花粉']='BlueHealing',['レストラル']='BlueHealing',['ホワイトウィンド']='BlueHealing',['ワイルドカロット']='BlueHealing',['虚無の風']='BlueHealing',['イグジュビエーション']='BlueHealing',
        --強化系青魔法
        ['N.メディテイト']='BlueBuff',['エラチックフラッター']='BlueBuff',['カウンタースタンス']='BlueBuff',['カルカリアンヴァーヴ']='BlueBuff',['コクーン']='BlueBuff',['セイリーンコート']='BlueBuff',['ゼファーマント']='BlueBuff',['ねたみ種']='BlueBuff',['バッテリーチャージ']='BlueBuff',['ファンタッド']='BlueBuff',['フェザーバリア']='BlueBuff',['プラズマチャージ']='BlueBuff',['ポーラーブルワーク']='BlueBuff',['マイティガード']='BlueBuff',['メメントモーリ']='BlueBuff',['リジェネレーション']='BlueBuff',['リフュエリング']='BlueBuff',['ワームアップ']='BlueBuff',['牙門']='BlueBuff',['共鳴']='BlueBuff',['鯨波']='BlueBuff',['甲羅強化']='BlueBuff',['反応炉冷却']='BlueBuff',['金剛身']='BlueBuff',['マジックバリア']='BlueBuff',['メタルボディ']='BlueBuff',['オカルテーション']='BlueBuff',
        }

        bp_spell_maps = {
        --召喚履行
        ['シアリングライト'] = 'AvatarMagicalPacts',['ルビーの癒し'] = 'AvatarCure',['ポイズンネイル'] = 'AvatarPhysicalPacts',['ルビーの輝き'] = 'AvatarBuffWard',['ルビーの煌き'] = 'AvatarBuffWard',
        ['プチメテオ'] = 'AvatarMagicalPacts',['ルビーの癒しII'] = 'AvatarCure',['ホーリーミスト'] = 'AvatarMagicalPacts',['ルビーの安らぎ'] = 'AvatarBuffWard',['ルビーの贖罪'] = 'AvatarBuffWard',
        ['アースフューリー'] = 'AvatarMagicalPacts',['ロックスロー'] = 'AvatarPhysicalPacts',['ストーンII'] = 'AvatarMagicalPacts',['ロックバスター'] = 'AvatarPhysicalPacts',['メガリススロー'] = 'AvatarPhysicalPacts',
        ['大地の守り'] = 'AvatarBuffWard',['ストーンIV'] = 'AvatarMagicalPacts',['マウンテンバスター'] = 'AvatarPhysicalPacts',['ジオクラッシュ'] = 'AvatarMagicalPacts',['大地の鎧'] = 'AvatarBuffWard',
        ['クラッグスロー'] = 'AvatarPhysicalPacts',
        ['タイダルウェイブ'] = 'AvatarMagicalPacts',['バラクーダダイブ'] = 'AvatarPhysicalPacts',['ウォータII'] = 'AvatarMagicalPacts',['テールウィップ'] = 'AvatarPhysicalPacts',['スロウガ'] = 'AvatarDeBuffWard',
        ['湧水'] = 'AvatarCure',['ウォータIV'] = 'AvatarMagicalPacts',['スピニングダイブ'] = 'AvatarPhysicalPacts',['グランドフォール'] = 'AvatarMagicalPacts',['タイダルロア'] = 'AvatarDeBuffWard',
        ['スージングカレント'] = 'AvatarBuffWard',
        ['エリアルブラスト'] = 'AvatarMagicalPacts',['クロー'] = 'AvatarPhysicalPacts',['エアロII'] = 'AvatarMagicalPacts',['真空の鎧'] = 'AvatarBuffWard',['風の囁き'] = 'AvatarCure',
        ['ヘイスガ'] = 'AvatarBuffWard',['エアロIV'] = 'AvatarMagicalPacts',['プレデタークロー'] = 'AvatarPhysicalPacts',['ウインドブレード'] = 'AvatarMagicalPacts',
        ['真空の具足'] = 'AvatarBuffWard',['ヘイスガII'] = 'AvatarBuffWard',
        ['インフェルノ'] = 'AvatarMagicalPacts',['パンチ'] = 'AvatarPhysicalPacts',['ファイアII'] = 'AvatarMagicalPacts',['バーニングストライク'] = 'AvatarMagicalPacts',['ダブルパンチ'] = 'AvatarPhysicalPacts',
        ['紅蓮の咆哮'] = 'AvatarBuffWard',['ファイアIV'] = 'AvatarMagicalPacts',['フレイムクラッシュ'] = 'AvatarMagicalPacts',['メテオストライク'] = 'AvatarMagicalPacts',['灼熱の咆哮'] = 'AvatarBuffWard',
        ['コンフラグストライク'] = 'AvatarMagicalPacts',
        ['ダイヤモンドダスト'] = 'AvatarMagicalPacts',['アクスキック'] = 'AvatarPhysicalPacts',['ブリザドII'] = 'AvatarMagicalPacts',['凍てつく鎧'] = 'AvatarBuffWard',['スリプガ'] = 'AvatarDeBuffWard',
        ['ダブルスラップ'] = 'AvatarPhysicalPacts',['ブリザドIV'] = 'AvatarMagicalPacts',['ラッシュ'] = 'AvatarPhysicalPacts',['ヘヴンリーストライク'] = 'AvatarMagicalPacts',
        ['ダイヤモンドストーム'] = 'AvatarDeBuffWard',['クリスタルブレシング'] = 'AvatarBuffWard',
        ['ジャッジボルト'] = 'AvatarMagicalPacts',['ショックストライク'] = 'AvatarPhysicalPacts',['サンダーII'] = 'AvatarMagicalPacts',['サンダースパーク'] = 'AvatarMagicalPacts',['雷鼓'] = 'AvatarBuffWard',
        ['雷電の鎧'] = 'AvatarBuffWard',['サンダーIV'] = 'AvatarMagicalPacts',['カオスストライク'] = 'AvatarPhysicalPacts',['サンダーストーム'] = 'AvatarMagicalPacts',
        ['スタンガ'] = 'AvatarDeBuffWard',['ボルトストライク'] = 'AvatarPhysicalPacts',
        ['ハウリングムーン'] = 'AvatarMagicalPacts',['ムーンリットチャージ'] = 'AvatarPhysicalPacts',['クレセントファング'] = 'AvatarPhysicalPacts',['ルナークライ'] = 'AvatarDeBuffWard',
        ['ルナーロア'] = 'AvatarDeBuffWard',['上弦の唸り'] = 'AvatarBuffWard',['下弦の咆哮'] = 'AvatarBuffWard',['エクリプスバイト'] = 'AvatarPhysicalPacts',['ルナーベイ'] = 'AvatarMagicalPacts',
        ['ヘヴンズハウル'] = 'AvatarBuffWard',['インパクト'] = 'AvatarMagicalPacts',
        ['ルイナスオーメン'] = 'AvatarMagicalPacts',['カミサドー'] = 'AvatarPhysicalPacts',['ソムノレンス'] = 'AvatarDeBuffWard',['ナイトメア'] = 'AvatarDeBuffWard',
        ['アルティメットテラー'] = 'AvatarDeBuffWard',['ノクトシールド'] = 'AvatarBuffWard',['ドリームシュラウド'] = 'AvatarBuffWard',['ネザーブラスト'] = 'AvatarMagicalPacts',
        ['ナイトテラー'] = 'AvatarMagicalPacts',['パボルノクターナス'] = 'AvatarDeBuffWard',['ブラインドサイド'] = 'AvatarPhysicalPacts',
        ['アルタナフェーバー'] = 'AvatarBuffWard',['リーガルスクラッチ'] = 'AvatarPhysicalPacts',['レイズII'] = 'AvatarBuffWard',['ミュインララバイ'] = 'AvatarDeBuffWard',
        ['リレイズII'] = 'AvatarBuffWard',['イアリーアイ'] = 'AvatarDeBuffWard',['レベル？ホーリー'] = 'AvatarMagicalPacts',['リーガルガッシュ'] = 'AvatarPhysicalPacts',
        ['クラーサクコール'] = 'AvatarMagicalPacts',['ウェルト'] = 'AvatarPhysicalPacts',['ルナティックボイス'] = 'AvatarDeBuffWard',['ラウンドハウス'] = 'AvatarPhysicalPacts',
        ['疾風の刃'] = 'AvatarBuffWard',['シヌーク'] = 'AvatarBuffWard',['修羅のエレジー'] = 'AvatarDeBuffWard',['ソニックバフェット'] = 'AvatarMagicalPacts',
        ['トルネドII'] = 'AvatarMagicalPacts',['風の守り'] = 'AvatarBuffWard',['ヒステリックアサルト'] = 'AvatarPhysicalPacts',
        ['斬鉄剣'] = 'AvatarDeBuffWard',['ディコンストラクション'] = 'AvatarDeBuffWard',['クロノシフト'] = 'AvatarDeBuffWard',['絶対防御'] = 'AvatarBuffWard',
    }
end


--■■■ロール情報
function define_roll_values()
    rolls = {
        ["コルセアズロール"]     = {lucky=5, unlucky=9, bonus="Exp+"},
        ["ニンジャロール"]       = {lucky=4, unlucky=8, bonus="Evasion+"},
        ["ハンターズロール"]     = {lucky=4, unlucky=8, bonus="Accuracy+"},
        ["カオスロール"]         = {lucky=4, unlucky=8, bonus="Attack+"},
        ["メガスズロール"]       = {lucky=2, unlucky=6, bonus="Magic Def+"},
        ["ヒーラーズロール"]     = {lucky=3, unlucky=7, bonus="被ケアル回復量"},
        ["ドラケンロール"]       = {lucky=4, unlucky=8, bonus="Pet Accuracy+"},
        ["コーラルロール"]       = {lucky=2, unlucky=6, bonus="詠唱中断率ダウン"},
        ["モンクスロール"]       = {lucky=3, unlucky=7, bonus="Subtle Blow+"},
        ["ビーストロール"]       = {lucky=4, unlucky=8, bonus="Pet Attack+"},
        ["サムライロール"]       = {lucky=2, unlucky=6, bonus="StoreTP+"},
        ["エボカーズロール"]     = {lucky=5, unlucky=9, bonus="Refresh+"},
        ["ローグズロール"]       = {lucky=5, unlucky=9, bonus="Critical Hit Rate+"},
        ["ワーロックスロール"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy+"},
        ["ファイターズロール"]   = {lucky=5, unlucky=9, bonus="Double Attack+"},
        ["パペットロール"]       = {lucky=4, unlucky=8, bonus="Pet Magic Atk&Acc+"},
        ["ガランツロール"]       = {lucky=3, unlucky=7, bonus="Def+"},
        ["ウィザーズロール"]     = {lucky=5, unlucky=9, bonus="Magic Atk+"},
        ["ダンサーロール"]       = {lucky=3, unlucky=7, bonus="Regen+"},
        ["スカラーロール"]       = {lucky=2, unlucky=6, bonus="Conserve MP+"},
        ["ナチュラリストロール"] = {lucky=3, unlucky=7, bonus="被強化魔法延長"},
        ["ルーニストロール"]     = {lucky=4, unlucky=8, bonus="Magic Evasion+"},
        ["ボルターズロール"]     = {lucky=3, unlucky=9, bonus="Quickening"},
        ["キャスターズロール"]   = {lucky=2, unlucky=7, bonus="FC+"},
        ["コアサーズロール"]     = {lucky=3, unlucky=9, bonus="Snap Shot+"},
        ["ブリッツァロール"]     = {lucky=4, unlucky=9, bonus="攻撃間隔"},
        ["タクティックロール"]   = {lucky=5, unlucky=8, bonus="Regain+"},
        ["アライズロール"]       = {lucky=3, unlucky=10,bonus="連携ダメージ・命中"},
        ["マイザーロール"]       = {lucky=5, unlucky=7, bonus="SaveTP+"},
        ["コンパニオンロール"]   = {lucky=2, unlucky=10,bonus="Pet Regen & Regain+"},
        ["カウンターロール"]     = {lucky=4, unlucky=8, bonus="Counter+"},
    }
end


--■■■ロール情報出力
function display_roll_info(spell)
    rollinfo = rolls[spell.japanese]
    if rollinfo then
        local desc = rolls[spell.name].bonus
        local lucky = rolls[spell.name].lucky
        local unlucky = rolls[spell.name].unlucky
        windower.add_to_chat(2, spell.name .. ' [' ..desc ..'] Lucky=' .. lucky .. ' '.. ' Unluck='.. unlucky)
    end
end


function set_default_ws_sets()
    for name, attr in pairs(WSAttrs) do
        sets.precast.WS[name] = {}
        if attr.class == WSClass.Melee then
            if attr.default == WSDefault.Damage then
                sets.precast.WS[name].Normal = sets.precast.WS.melee
            elseif attr.default == WSDefault.Critical then
                sets.precast.WS[name].Normal = sets.precast.WS.melee_critical
            elseif attr.default == WSDefault.Multi then
                sets.precast.WS[name].Normal = sets.precast.WS.melee_multi
            elseif attr.default == WSDefault.Debuf then
                sets.precast.WS[name].Normal = sets.precast.WS.melee_debuf
            end
            sets.precast.WS[name].Accuracy = sets.precast.WS.melee_accuracy
        elseif attr.class == WSClass.Ranged then
            if attr.default == WSDefault.Damage then
                sets.precast.WS[name].Normal = sets.precast.WS.ranged
            elseif attr.default == WSDefault.Critical then
                sets.precast.WS[name].Normal = sets.precast.WS.ranged_critical
            elseif attr.default == WSDefault.Multi then
                sets.precast.WS[name].Normal = sets.precast.WS.ranged_multi
            elseif attr.default == WSDefault.Debuf then
                sets.precast.WS[name].Normal = sets.precast.WS.ranged_debuf
            end
            sets.precast.WS[name].Accuracy = sets.precast.WS.ranged_accuracy
        elseif attr.class == WSClass.Magical then
            sets.precast.WS[name].Normal = sets.precast.WS.magical
            sets.precast.WS[name].Accuracy = sets.precast.WS.magical_accuracy
        elseif attr.class == WSClass.HybridMelee then
            sets.precast.WS[name].Normal = sets.precast.WS.hybrid_melee
            sets.precast.WS[name].Accuracy = sets.precast.WS.melee_accuracy
        elseif attr.class == WSClass.HybridRanged then
            sets.precast.WS[name].Normal = sets.precast.WS.hybrid_ranged
            sets.precast.WS[name].Accuracy = sets.precast.WS.ranged_accuracy
        elseif attr.class == WSClass.Breath then
            sets.precast.WS[name].Normal = sets.precast.WS.breath
        elseif attr.class == WSClass.None then
            sets.precast.WS[name].Normal = sets.precast.WS.none
        else
            sets.precast.WS[name].Normal = sets.precast.WS.Damage -- Default to Damage if no class is defined.
        end

        sets.precast.WS[name].SubtleBlow = set_combine(sets.precast.WS.Damage, sets.precast.WS.SubtleBlow)
    end
end


function init_gears()
    gear.AmbusMantle = {}
    gear.LaiveMantle = {}
end
