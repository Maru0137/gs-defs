-- Common definition file for all jobs and all characters.

-- Initial setup
function user_setup()
    state.Buff['睡眠']  = buffactive['睡眠'] or false                   --監視するバフ・デバフ
    
    -- include(player.name .. '/weather_obi')                              --属性帯ロード    
    -- include('smn_avatar')                                               --召喚定義ファイルロード
    -- include('organizer-lib') 
    define_roll_values()                                                --ロール情報   
    init_weaponns()                                                     --武器初期化
    init_custom_spell_map()                                             --スペルマップ定義再構築    
    init_gears()
    init_weapon_skill_sets()

    send_command('input /chatmode party')                               --チャットモード変更
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
end


--■■■アクション中処理（共通実装なし）
function user_post_midcast(spell, action, spellMap, eventArgs)
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

function init_weapon_skill_sets()
    -- 物理: sets.precast.WS.phys
        -- 近接: sets.precast.WS.phys.melee
            -- 初段倍率: sets.precast.WS.phys.melee.first
                -- TPダメージ修正: sets.precast.WS.phys.melee.first.damage
                -- クリティカル: sets.precast.WS.phys.melee.first.crit
                -- 追加効果: sets.precast.WS.phys.melee.first.debuf
                -- その他: sets.precast.WS.phys.melee.first.other
            -- 全段倍率: sets.precast.WS.phys.melee.multi
                -- TPダメージ修正: sets.precast.WS.phys.melee.multi.damage
                -- クリティカル: sets.precast.WS.phys.melee.multi.crit
                -- 追加効果: sets.precast.WS.phys.melee.multi.debuf
                -- その他: sets.precast.WS.phys.melee.multi.other
        -- 遠隔: sets.precast.WS.phys.range
            -- 初段倍率: sets.precast.WS.phys.range.first
                -- TPダメージ修正: sets.precast.WS.phys.range.first.damage
                -- クリティカル: sets.precast.WS.phys.range.first.crit
                -- 追加効果: sets.precast.WS.phys.range.first.debuf
                -- その他: sets.precast.WS.phys.range.first.other
            -- 全段倍率: sets.precast.WS.phys.range.multi
                -- TPダメージ修正: sets.precast.WS.phys.range.multi.damage
                -- クリティカル: sets.precast.WS.phys.range.multi.crit
    -- 属性: sets.precast.WS.magic
                -- TPダメージ修正: sets.precast.WS.magic.damage
                -- 追加効果: sets.precast.WS.magic.debuf
                -- その他: sets.precast.WS.magic.other
    -- 属性物理: sets.precast.WS.magicphys
    -- ブレス: sets.precast.WS.breath
                -- TPダメージ修正: sets.precast.WS.breath.damage
                -- その他: sets.precast.WS.breath.other

    sets.precast.WS.phys = {}
    sets.precast.WS.phys.melee = {}
    sets.precast.WS.phys.melee.first = {}
    sets.precast.WS.phys.melee.first.damage = {}
    sets.precast.WS.phys.melee.first.crit = {}
    sets.precast.WS.phys.melee.first.debuf = {}
    sets.precast.WS.phys.melee.first.other = {}
    sets.precast.WS.phys.melee.multi = {}
    sets.precast.WS.phys.melee.multi.damage = {}
    sets.precast.WS.phys.melee.multi.crit = {}
    sets.precast.WS.phys.melee.multi.debuf = {}
    sets.precast.WS.phys.melee.multi.other = {}
    sets.precast.WS.phys.range = {}
    sets.precast.WS.phys.range.first = {}
    sets.precast.WS.phys.range.first.damage = {}
    sets.precast.WS.phys.range.first.crit = {}
    sets.precast.WS.phys.range.first.debuf = {}
    sets.precast.WS.phys.range.first.other = {}
    sets.precast.WS.phys.range.multi = {}
    sets.precast.WS.phys.range.multi.damage = {}
    sets.precast.WS.phys.range.multi.crit = {}
    sets.precast.WS.magic = {}
    sets.precast.WS.magic.damage = {}
    sets.precast.WS.magic.debuf = {}
    sets.precast.WS.magic.other = {}
    sets.precast.WS.magicphys = {}
    sets.precast.WS.breath = {}
    sets.precast.WS.breath.damage = {}
    sets.precast.WS.breath.other = {}

    -- A category is described as 9-bit bitset.
    WSCategoryId = {
        Phys = 0,
        Magic = 64,
        MagicPhys = 128,
        Breath = 192,
        Heal = 256,

        Melee = 0,
        Range = 32,

        First = 0,
        Multi = 16,

        Fire = 0,
        Ice = 4,
        Wind = 8,
        Earth = 12,
        Lightning = 16,
        Water = 20,
        Light = 24,
        Dark = 28,

        Damage = 0,
        Crit = 1,
        Debuf = 2,
        Other = 3,
   }

    WSCategoryMap = {}

    WSCategoryMap["コンボ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["タックル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Debuf
    WSCategoryMap["短勁"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["バックハンドブロー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["乱撃"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["スピンアタック"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["空鳴拳"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["双竜脚"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["夢想阿修羅拳"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["闘魂旋風脚"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["ファイナルパラダイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ファイナルヘヴン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["アスケーテンツォルン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["連関六合圏"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["ビクトリースマイト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["四神円舞"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Debuf
    WSCategoryMap["ドラゴンブロウ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["マスカラ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["ワスプスティング"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ガストスラッシュ"] = WSCategoryId.Magic | WSCategoryId.Wind | WSCategoryId.Damage
    WSCategoryMap["シャドーステッチ"] = WSCategoryId.Phys | WSCategoryMap.Melee | WSCategoryMap.First | WSCategoryId.Debuf
    WSCategoryMap["バイパーバイト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["サイクロン"] = WSCategoryId.Magic | WSCategoryId.Wind | WSCategoryId.Damage
    WSCategoryMap["エナジースティール"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Other
    WSCategoryMap["エナジードレイン"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Other
    WSCategoryMap["ダンシングエッジ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["シャークバイト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["エヴィサレーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["イオリアンエッジ"] = WSCategoryId.Magic | WSCategoryId.Wind | WSCategoryId.Damage
    WSCategoryMap["マーシーストローク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["マンダリクスタッブ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["モーダントライム"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ピリッククレオス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Debuf
    WSCategoryMap["ルドラストーム"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["エクゼンテレター"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Debuf
    WSCategoryMap["ルースレスストローク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["ファストブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["バーニングブレード"] = WSCategoryId.Magic | WSCategoryId.Fire | WSCategoryId.Damage
    WSCategoryMap["レッドロータス"] = WSCategoryId.Magic | WSCategoryId.Fire | WSCategoryId.Damage
    WSCategoryMap["フラットブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["シャインブレード"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["セラフブレード"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["サークルブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スピリッツウィズイン"] = WSCategoryId.Breath | WSCategoryId.Damage
    WSCategoryMap["ボーパルブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["スウィフトブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["サベッジブレード"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["サンギンブレード"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Other
    WSCategoryMap["ナイスオブランド"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ナイツオブランド"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ロズレーファタール"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ロイエ"] = WSCategoryId.Breath | WSCategoryId.Other
    WSCategoryMap["エクスピアシオン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ウリエルブレード"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["グローリースラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["シャンデュシニュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["レクイエスカット"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["ファストブレードII"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["インペラトル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["ハードスラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["パワースラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["フロストバイト"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Damage
    WSCategoryMap["フリーズバイト"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Damage
    WSCategoryMap["ショックウェーブ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["クレセントムーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["シックルムーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スピンスラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["グラウンドストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ヘラクレススラッシュ"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Debuf
    WSCategoryMap["スカージ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["トアクリーバー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["レゾルーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["デミディエーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["フィンブルヴェト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["レイジングアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スマッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ラファールアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["アバランチアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スピニングアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ランページ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["カラミティ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ミストラルアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["デシメーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["ボーラアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["オンスロート"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["プライマルレンド"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["クラウドスプリッタ"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
    WSCategoryMap["ルイネーター"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["ブリッツ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["シールドブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["アイアンテンペスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["シュトルムヴィント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Othe
    WSCategoryMap["アーマーブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["キーンエッジ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["ウェポンブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["レイジングラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["フルブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["スチールサイクロン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["フェルクリーヴ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["メタトロントーメント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["キングズジャスティス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ウッコフューリー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["アップヒーバル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ディザスター"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["ダブルスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damag
    WSCategoryMap["サンダースラスト"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
    WSCategoryMap["ライデンスラスト"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
    WSCategoryMap["足払い"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ペンタスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ボーパルスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["スキュアー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["大車輪"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["インパルスドライヴ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ソニックスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ゲイルスコグル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["雲蒸竜変"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["カムラン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["スターダイバー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["ダーマット"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["スライス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ダークハーベスト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["シャドーオブデス"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["ナイトメアサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["スピニングサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ボーパルサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["ギロティン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["クロスリーパー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スパイラルヘル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["インファナルサイズ"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
    WSCategoryMap["カタストロフィ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["インサージェンシー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["クワイタス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["エントロピー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["ジ・オリジン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["臨"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["烈"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["滴"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Water | WSCategoryId.Damage
    WSCategoryMap["凍"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Ice | WSCategoryId.Damage
    WSCategoryMap["地"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Earth | WSCategoryId.Damage
    WSCategoryMap["影"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["迅"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["天"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["空"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["湧"] = WSCategoryId.Magic | WSCategoryId.Water | WSCategoryId.Debuf
    WSCategoryMap["生者必滅"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["カムハブリ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["秘"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["瞬"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["是生滅法"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["壱之太刀・燕飛"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["弐之太刀・鋒縛"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["参之太刀・轟天"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Lightning | WSCategoryId.Damage
    WSCategoryMap["四之太刀・陽炎"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Fire | WSCategoryId.Damage
    WSCategoryMap["五之太刀・陣風"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Wind | WSCategoryId.Damage
    WSCategoryMap["六之太刀・光輝"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["七之太刀・雪風"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["八之太刀・月光"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["九之太刀・花車"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["十一之太刀・鳳蝶"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["盛夏之太刀・西瓜割"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["零之太刀・回天"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["十之太刀・乱鴉"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["祖之太刀・不動"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["十二之太刀・照破"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["絶之太刀・無名"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["シャインストライク"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["セラフストライク"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["ブレインシェイカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["スターライト"] = WSCategoryId.Heal
    WSCategoryMap["ムーンライト"] = WSCategoryId.Heal
    WSCategoryMap["スカルブレイカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["トゥルーストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ジャッジメント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ヘキサストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["ブラックヘイロー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["フラッシュノヴァ"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Debuf
    WSCategoryMap["ランドグリース"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ミスティックブーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ダガン"] = WSCategoryId.Heal
    WSCategoryMap["レルムレイザー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
    WSCategoryMap["エクズデーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ダグダ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["スターバースト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ロッククラッシャー"] = WSCategoryId.Magic | WSCategoryId.Earth | WSCategoryId.Damage
    WSCategoryMap["アースクラッシャー"] = WSCategoryId.Magic | WSCategoryId.Earth | WSCategoryId.Damage
    -- TODO: Support randomize Light or Dark element.
    WSCategoryMap["スターバースト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["サンバースト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["シェルクラッシャー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["フルスイング"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["スピリットテーカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["レトリビューション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["カタクリスム"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["タルタロスゲート"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ヴィゾフニル"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
    WSCategoryMap["ガーランドオブブリス"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Debuf
    WSCategoryMap["オムニシエンス"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
    WSCategoryMap["タルタロストーパー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["ミルキル"] = WSCategoryId.Heal
    WSCategoryMap["シャッターソウル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["オシャラ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["フレイミングアロー"] = WSCategoryId.MagicPhys | WSCategoryId.Range | WSCategoryId.Fire | WSCategoryId.Damage
    WSCategoryMap["ピアシングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ダリングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["サイドワインダー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ブラストアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["アーチングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["エンピリアルアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["リフルジェントアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["南無八幡"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ジシュヌの光輝"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.Multi | WSCategoryId.Crit
    WSCategoryMap["エイペクスアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["シャルヴ"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage

    WSCategoryMap["ホットショット"] = WSCategoryId.MagicPhys | WSCategoryId.Range | WSCategoryId.Fire | WSCategoryId.Damage
    WSCategoryMap["スプリットショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["スナイパーショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["スラッグショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ブラストショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["ヘヴィショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
    WSCategoryMap["デトネーター"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
    WSCategoryMap["ナビングショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Debuf
    WSCategoryMap["カラナック"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
    WSCategoryMap["トゥルーフライト"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
    WSCategoryMap["レデンサリュート"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
    WSCategoryMap["ワイルドファイア"] = WSCategoryId.Magic | WSCategoryId.Fire | WSCategoryId.Other
    WSCategoryMap["ラストスタンド"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.Multi | WSCategoryId.Damage
    WSCategoryMap["ジ・エンド"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
end


function init_weapon_skill()
    --近接物理ダメージ：sets.precast.WS.Damage
    --近接クリティカル：sets.precast.WS.Critical
    --魔攻：sets.precast.WS.Magic
    --遠隔物理ダメージ：sets.precast.WS.Damage
    
    sets.precast.WS["コンボ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["タックル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["短勁"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["バックハンドブロー"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["乱撃"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピンアタック"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["空鳴拳"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["双竜脚"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["夢想阿修羅拳"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["闘魂旋風脚"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ファイナルパラダイス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ファイナルヘヴン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アスケーテンツォルン"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["連環六合圏"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ビクトリースマイト"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["四神円舞"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ドラゴンブロウ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["マルカラ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ワスプスティング"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ガストスラッシュ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャドーステッチ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["バイパーバイト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サイクロン"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エナジースティール"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エナジードレイン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダンシングエッジ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャークバイト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エヴィサレーション"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["イオリアンエッジ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["マーシーストローク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["マンダリクスタッブ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["モーダントライム"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ピリッククレオス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ルドラストーム"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エクゼンテレター"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ルースレスストローク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ファストブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["バーニングブレード"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レッドロータス"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フラットブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャインブレード"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["セラフブレード"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サークルブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピリッツウィズイン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ボーパルブレード"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スウィフトブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サベッジブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サンギンブレード"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ナイスオブラウンド"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ナイツオブラウンド"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ロズレーファタール"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ロイエ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エクスピアシオン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ウリエルブレード"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["グローリースラッシュ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャンデュシニュ"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レクイエスカット"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ファストブレードII"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["インペラトル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ハードスラッシュ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["パワースラッシュ"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フロストバイト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フリーズバイト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ショックウェーブ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["クレセントムーン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シックルムーン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピンスラッシュ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["グラウンドストライク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ヘラクレススラッシュ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スカージ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["トアクリーバー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レゾルーション"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["デミディエーション"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フィンブルヴェト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["レイジングアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スマッシュ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ラファールアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アバランチアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピニングアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ランページ"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カラミティ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ミストラルアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["デシメーション"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ボーラアクス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["オンスロート"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["プライマルレンド"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["クラウドスプリッタ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ルイネーター"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ブリッツ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["シールドブレイク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アイアンテンペスト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シュトルムヴィント"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アーマーブレイク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["キーンエッジ"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ウェポンブレイク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レイジングラッシュ"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フルブレイク"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スチールサイクロン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フェルクリーヴ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["メタトロントーメント"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["キングズジャスティス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ウッコフューリー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アップヒーバル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ディザスター"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["スライス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダークハーベスト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャドーオブデス"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ナイトメアサイス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピニングサイス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ボーパルサイス"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ギロティン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["クロスリーパー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スパイラルヘル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["インファナルサイズ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カタストロフィ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["インサージェンシー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["クワイタス"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エントロピー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ジ・オリジン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ダブルスラスト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サンダースラスト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ライデンスラスト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["足払い"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ペンタスラスト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ボーパルスラスト"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スキュアー"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["大車輪"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["インパルスドライヴ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ソニックスラスト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ゲイルスコグル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["雲蒸竜変"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カムラン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スターダイバー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダーマット"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["臨"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["烈"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["滴"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["凍"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["地"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["影"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["迅"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["天"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["空"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["湧"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["生者必滅"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カムハブリ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["秘"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["瞬"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["是生滅法"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["壱之太刀・燕飛"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["弐之太刀・鋒縛"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["参之太刀・轟天"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["四之太刀・陽炎"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["五之太刀・陣風"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["六之太刀・光輝"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["七之太刀・雪風"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["八之太刀・月光"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["九之太刀・花車"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["十一之太刀・鳳蝶"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["盛夏之太刀・西瓜割"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["零之太刀・回天"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["十之太刀・乱鴉"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["祖之太刀・不動"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["十二之太刀・照破"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["絶之太刀・無名"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["シャインストライク"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["セラフストライク"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ブレインシェイカー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スターライト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ムーンライト"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スカルブレイカー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["トゥルーストライク"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ジャッジメント"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ヘキサストライク"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ブラックヘイロー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フラッシュノヴァ"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ランドグリース"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ミスティックブーン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダガン"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レルムレイザー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エクズデーション"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダグダ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ヘヴィスイング"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ロッククラッシャー"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アースクラッシャー"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スターバースト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サンバースト"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シェルクラッシャー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["フルスイング"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スピリットテーカー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レトリビューション"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カタクリスム"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["タルタロスゲート"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ヴィゾフニル"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ガーランドオブブリス"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["オムニシエンス"] = { Normal=sets.precast.WS.Magic ,SubtleBlow=set_combine(sets.precast.WS.Magic ,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["タルタロストーパー"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ミルキル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャッターソウル"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["オシャラ"] = { Normal=sets.precast.WS.Damage,SubtleBlow=set_combine(sets.precast.WS.Damage,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["フレイミングアロー"] = { Normal=sets.precast.WS.Magic,SubtleBlow=set_combine(sets.precast.WS.Magic,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ピアシングアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ダリングアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["サイドワインダー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ブラストアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["アーチングアロー"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エンピリアルアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["リフルジェントアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["南無八幡"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ジシュヌの光輝"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["エイペクスアロー"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["シャルヴ"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}

    sets.precast.WS["ホットショット"] = { Normal=sets.precast.WS.Magic,SubtleBlow=set_combine(sets.precast.WS.Magic,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スプリットショット"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スナイパーショット"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["スラッグショット"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ブラストショット"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ヘヴィショット"] = { Normal=sets.precast.WS.Critical,SubtleBlow=set_combine(sets.precast.WS.Critical,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["デトネーター"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ナビングショット"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["カラナック"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["トゥルーフライト"] = { Normal=sets.precast.WS.Magic,SubtleBlow=set_combine(sets.precast.WS.Magic,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["レデンサリュート"] = { Normal=sets.precast.WS.Magic,SubtleBlow=set_combine(sets.precast.WS.Magic,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ワイルドファイア"] = { Normal=sets.precast.WS.Magic,SubtleBlow=set_combine(sets.precast.WS.Magic,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ラストスタンド"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
    sets.precast.WS["ジ・エンド"] = { Normal=sets.precast.WS.Range,SubtleBlow=set_combine(sets.precast.WS.Range,sets.precast.WS.SubtleBlow)}
end

function init_gears()
    gear.AmbusMantle = {}
    gear.MoonshadeEarring = { name = "胡蝶のイヤリング", augments = { '"Mag.Atk.Bns."+4', 'TP Bonus +250', } }
end
        