-- WSAttr tree:
-- * melee
--   * melee_critical
--   * melee_multi
--   * melee_debuf
--   * melee_accuracy
-- * ranged
--   * ranged_critical
--   * ranged_multi
--   * ranged_debuf
--   * ranged_accuracy
-- * magical
--   * magical_accuracy
-- * hybrid
--   * hybrid_melee
--     * hybrid_melee_accuracy (-> melee_accuracy)
--   * hybrid_ranged
--     * hybrid_ranged_accuracy (-> ranged_accuracy)
-- * breath
-- none

WSClass = {
  Melee = 1,
  Ranged = 2,
  Magical = 3,
  HybridMelee = 4,
  HybridRanged = 5,
  Breath = 6,
  None = 7,
}

WSDefault = {
  Damage = 1,
  Critical = 2,
  Multi = 3,
  Debuf = 4,
}

function init_ws_attr_map()
  WSAttrs = {}

  WSAttrs["コンボ"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["タックル"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["短勁"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["バックハンドブロー"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["乱撃"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["スピンアタック"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["空鳴拳"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["双竜脚"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["夢想阿修羅拳"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["闘魂旋風脚"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ファイナルパラダイス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ファイナルヘヴン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["アスケーテンツォルン"] = { class = WSClass.Melee, WSDefault.Critical }
  WSAttrs["連関六合圏"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["ビクトリースマイト"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["四神円舞"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ドラゴンブロウ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["マルカラ"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["ワスプスティング"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ガストスラッシュ"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["シャドーステッチ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["バイパーバイト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["サイクロン"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["エナジースティール"] = { class = WSClass.Magic, default = WSDefault.Damage }
  WSAttrs["エナジードレイン"] = { class = WSClass.Magic, default = WSDefault.Damage }
  WSAttrs["ダンシングエッジ"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["シャークバイト"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["エヴィサレーション"] = { class = WSClass.Physical, default = WSDefault.Critical }
  WSAttrs["イオリアンエッジ"] = { class = WSClass.Magic, default = WSDefault.Damage }
  WSAttrs["マーシーストローク"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["マンダリクスタッブ"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["モーダントライム"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["ピリッククレオス"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["ルドラストーム"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["エクゼンテレター"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["ルースレスストローク"] = { class = WSClass.Physical, default = WSDefault.Damage }

  WSAttrs["ファストブレード"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["バーニングブレード"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["レッドロータス"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["フラットブレード"] = { class = WSClass.Physical, default = WSDefault.Debuf }
  WSAttrs["シャインブレード"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["セラフブレード"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["サークルブレード"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["スピリッツウィズイン"] = { class = WSClass.Breath, default = WSDefault.Damage }
  WSAttrs["ボーパルブレード"] = { class = WSClass.Physical, default = WSDefault.Critical }
  WSAttrs["スウィフトブレード"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["サベッジブレード"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["サンギンブレード"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["ナイスオブランド"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["ナイツオブランド"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["ロズレーファタール"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["ロイエ"] = { class = WSClass.Breath, default = WSDefault.Damage }
  WSAttrs["エクスピアシオン"] = { class = WSClass.Physical, default = WSDefault.Damage }
  WSAttrs["ウリエルブレード"] = { class = WSClass.Magical, default = WSDefault.Damage }
  WSAttrs["グローリースラッシュ"] = { class = WSClass.Physical, default = WSDefault.Debuf }
  WSAttrs["シャンデュシニュ"] = { class = WSClass.Physical, default = WSDefault.Critical }
  WSAttrs["レクイエスカット"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["ファストブレードII"] = { class = WSClass.Physical, default = WSDefault.Multi }
  WSAttrs["インペラトル"] = { class = WSClass.Physical, default = WSDefault.Damage }

  WSAttrs["ハードスラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["パワースラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["フロストバイト"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Damage
  WSAttrs["フリーズバイト"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Damage
  WSAttrs["ショックウェーブ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["クレセントムーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["シックルムーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["スピンスラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["グラウンドストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ヘラクレススラッシュ"] = WSCategoryId.Magic | WSCategoryId.Ice | WSCategoryId.Debuf
  WSAttrs["スカージ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["トアクリーバー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["レゾルーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
  WSAttrs["デミディエーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["フィンブルヴェト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["レイジングアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["スマッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["ラファールアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["アバランチアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["スピニングアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ランページ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
  WSAttrs["カラミティ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ミストラルアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["デシメーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
  WSAttrs["ボーラアクス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["オンスロート"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["プライマルレンド"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
  WSAttrs["クラウドスプリッタ"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
  WSAttrs["ルイネーター"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
  WSAttrs["ブリッツ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["シールドブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["アイアンテンペスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["シュトルムヴィント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Othe
  WSAttrs["アーマーブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["キーンエッジ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["ウェポンブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["レイジングラッシュ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["フルブレイク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["スチールサイクロン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["フェルクリーヴ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["メタトロントーメント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["キングズジャスティス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ウッコフューリー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["アップヒーバル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ディザスター"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["ダブルスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damag
  WSAttrs["サンダースラスト"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
  WSAttrs["ライデンスラスト"] = WSCategoryId.Magic | WSCategoryId.Lightning | WSCategoryId.Damage
  WSAttrs["足払い"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["ペンタスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ボーパルスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["スキュアー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["大車輪"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["インパルスドライヴ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ソニックスラスト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ゲイルスコグル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["雲蒸竜変"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["カムラン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["スターダイバー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
  WSAttrs["ダーマット"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["スライス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ダークハーベスト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["シャドーオブデス"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["ナイトメアサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["スピニングサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ボーパルサイス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["ギロティン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["クロスリーパー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["スパイラルヘル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["インファナルサイズ"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
  WSAttrs["カタストロフィ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["インサージェンシー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["クワイタス"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["エントロピー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Damage
  WSAttrs["ジ・オリジン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["臨"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["烈"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["滴"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Water | WSCategoryId.Damage
  WSAttrs["凍"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Ice | WSCategoryId.Damage
  WSAttrs["地"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Earth | WSCategoryId.Damage
  WSAttrs["影"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["迅"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
  WSAttrs["天"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["空"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
  WSAttrs["湧"] = WSCategoryId.Magic | WSCategoryId.Water | WSCategoryId.Debuf
  WSAttrs["生者必滅"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["カムハブリ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["秘"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["瞬"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
  WSAttrs["是生滅法"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["壱之太刀・燕飛"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["弐之太刀・鋒縛"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["参之太刀・轟天"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Lightning | WSCategoryId.Damage
  WSAttrs["四之太刀・陽炎"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Fire | WSCategoryId.Damage
  WSAttrs["五之太刀・陣風"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Wind | WSCategoryId.Damage
  WSAttrs["六之太刀・光輝"] = WSCategoryId.MagicPhys | WSCategoryId.Melee | WSCategoryId.Light | WSCategoryId.Damage
  WSAttrs["七之太刀・雪風"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["八之太刀・月光"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["九之太刀・花車"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["十一之太刀・鳳蝶"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["盛夏之太刀・西瓜割"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["零之太刀・回天"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["十之太刀・乱鴉"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["祖之太刀・不動"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["十二之太刀・照破"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["絶之太刀・無名"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["シャインストライク"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
  WSAttrs["セラフストライク"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
  WSAttrs["ブレインシェイカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["スターライト"] = WSCategoryId.Heal
  WSAttrs["ムーンライト"] = WSCategoryId.Heal
  WSAttrs["スカルブレイカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["トゥルーストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ジャッジメント"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ヘキサストライク"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Crit
  WSAttrs["ブラックヘイロー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["フラッシュノヴァ"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Debuf
  WSAttrs["ランドグリース"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["ミスティックブーン"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ダガン"] = WSCategoryId.Heal
  WSAttrs["レルムレイザー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.Multi | WSCategoryId.Other
  WSAttrs["エクズデーション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ダグダ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["スターバースト"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ロッククラッシャー"] = WSCategoryId.Magic | WSCategoryId.Earth | WSCategoryId.Damage
  WSAttrs["アースクラッシャー"] = WSCategoryId.Magic | WSCategoryId.Earth | WSCategoryId.Damage
  -- TODO: Support randomize Light or Dark element.
  WSAttrs["スターバースト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["サンバースト"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["シェルクラッシャー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["フルスイング"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["スピリットテーカー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["レトリビューション"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["カタクリスム"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["タルタロスゲート"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["ヴィゾフニル"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
  WSAttrs["ガーランドオブブリス"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Debuf
  WSAttrs["オムニシエンス"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Debuf
  WSAttrs["タルタロストーパー"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["ミルキル"] = WSCategoryId.Heal
  WSAttrs["シャッターソウル"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["オシャラ"] = WSCategoryId.Phys | WSCategoryId.Melee | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["フレイミングアロー"] = WSCategoryId.MagicPhys | WSCategoryId.Range | WSCategoryId.Fire | WSCategoryId.Damage
  WSAttrs["ピアシングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ダリングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["サイドワインダー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ブラストアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["アーチングアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["エンピリアルアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["リフルジェントアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["南無八幡"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ジシュヌの光輝"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.Multi | WSCategoryId.Crit
  WSAttrs["エイペクスアロー"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["シャルヴ"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage

  WSAttrs["ホットショット"] = WSCategoryId.MagicPhys | WSCategoryId.Range | WSCategoryId.Fire | WSCategoryId.Damage
  WSAttrs["スプリットショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["スナイパーショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["スラッグショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ブラストショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["ヘヴィショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Crit
  WSAttrs["デトネーター"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
  WSAttrs["ナビングショット"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Debuf
  WSAttrs["カラナック"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Other
  WSAttrs["トゥルーフライト"] = WSCategoryId.Magic | WSCategoryId.Light | WSCategoryId.Damage
  WSAttrs["レデンサリュート"] = WSCategoryId.Magic | WSCategoryId.Dark | WSCategoryId.Damage
  WSAttrs["ワイルドファイア"] = WSCategoryId.Magic | WSCategoryId.Fire | WSCategoryId.Other
  WSAttrs["ラストスタンド"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.Multi | WSCategoryId.Damage
  WSAttrs["ジ・エンド"] = WSCategoryId.Phys | WSCategoryId.Range | WSCategoryId.First | WSCategoryId.Damage
end
