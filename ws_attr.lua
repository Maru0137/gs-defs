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
-- * none

WSClass = {
  Melee = 1,
  Ranged = 2,
  Magical = 3,
  HybridMelee = 4,
  HybridRanged = 5,
  Breath = 6,
  None = 7,
}

WSElem = {
  Fire = 1,
  Ice = 2,
  Wind = 3,
  Eath = 4,
  Lightning = 5,
  Water = 6,
  Light = 7,
  Dark = 8,
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
  WSAttrs["ガストスラッシュ"] = { class = WSClass.Magical, elem = WSElem.Wind, default = WSDefault.Damage }
  WSAttrs["シャドーステッチ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["バイパーバイト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["サイクロン"] = { class = WSClass.Magical, elem = WSElem.Wind, default = WSDefault.Damage }
  WSAttrs["エナジースティール"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["エナジードレイン"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["ダンシングエッジ"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["シャークバイト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["エヴィサレーション"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["イオリアンエッジ"] = { class = WSClass.Magical, elem = WSElem.Wind, default = WSDefault.Damage }
  WSAttrs["マーシーストローク"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["マンダリクスタッブ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["モーダントライム"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ピリッククレオス"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ルドラストーム"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["エクゼンテレター"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ルースレスストローク"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["ファストブレード"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["バーニングブレード"] = { class = WSClass.Magical, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["レッドロータス"] = { class = WSClass.Magical, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["フラットブレード"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["シャインブレード"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["セラフブレード"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["サークルブレード"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スピリッツウィズイン"] = { class = WSClass.Breath, default = WSDefault.Damage }
  WSAttrs["ボーパルブレード"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["スウィフトブレード"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["サベッジブレード"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["サンギンブレード"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["ナイスオブランド"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ナイツオブランド"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ロズレーファタール"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ロイエ"] = { class = WSClass.Breath, default = WSDefault.Damage }
  WSAttrs["エクスピアシオン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ウリエルブレード"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["グローリースラッシュ"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["シャンデュシニュ"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["レクイエスカット"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ファストブレードII"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["インペラトル"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["ハードスラッシュ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["パワースラッシュ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["フロストバイト"] = { class = WSClass.Magical, elem = WSElem.Ice, default = WSDefault.Damage }
  WSAttrs["フリーズバイト"] = { class = WSClass.Magical, elem = WSElem.Ice, default = WSDefault.Damage }
  WSAttrs["ショックウェーブ"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["クレセントムーン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["シックルムーン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スピンスラッシュ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["グラウンドストライク"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ヘラクレススラッシュ"] = { class = WSClass.Magical, elem = WSElem.Ice, default = WSDefault.Damage }
  WSAttrs["スカージ"] = { class = WSClass.Melee, default = WSDefault.Other }
  WSAttrs["トアクリーバー"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["レゾルーション"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["デミディエーション"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["フィンブルヴェト"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["レイジングアクス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スマッシュ"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["ラファールアクス"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["アバランチアクス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スピニングアクス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ランページ"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["カラミティ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ミストラルアクス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["デシメーション"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ボーラアクス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["オンスロート"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["プライマルレンド"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["クラウドスプリッタ"] = { class = WSClass.Magical, elem = WSElem.Lightning, default = WSDefault.Damage }
  WSAttrs["ルイネーター"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ブリッツ"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["シールドブレイク"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["アイアンテンペスト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["シュトルムヴィント"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["アーマーブレイク"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["キーンエッジ"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["ウェポンブレイク"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["レイジングラッシュ"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["フルブレイク"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["スチールサイクロン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["フェルクリーヴ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["メタトロントーメント"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["キングズジャスティス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ウッコフューリー"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["アップヒーバル"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ディザスター"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["ダブルスラスト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["サンダースラスト"] = { class = WSClass.Magical, elem = WSElem.Lightning, default = WSDefault.Damage }
  WSAttrs["ライデンスラスト"] = { class = WSClass.Magical, elem = WSElem.Lightning, default = WSDefault.Damage }
  WSAttrs["足払い"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["ペンタスラスト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ボーパルスラスト"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["スキュアー"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["大車輪"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["インパルスドライヴ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ソニックスラスト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ゲイルスコグル"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["雲蒸竜変"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["カムラン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スターダイバー"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ダーマット"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["スライス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ダークハーベスト"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["シャドーオブデス"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["ナイトメアサイス"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["スピニングサイス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ボーパルサイス"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["ギロティン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["クロスリーパー"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スパイラルヘル"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["インファナルサイズ"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["カタストロフィ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["インサージェンシー"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["クワイタス"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["エントロピー"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ジ・オリジン"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["臨"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["烈"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["滴"] = { class = WSClass.HybridMelee, elem = WSElem.Water, default = WSDefault.Damage }
  WSAttrs["凍"] = { class = WSClass.HybridMelee, elem = WSElem.Ice, default = WSDefault.Damage }
  WSAttrs["地"] = { class = WSClass.HybridMelee, elem = WSElem.Earth, default = WSDefault.Damage }
  WSAttrs["影"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["迅"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["天"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["空"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["湧"] = { class = WSClass.Magical, elem = WSElem.Water, default = WSDefault.Damage }
  WSAttrs["生者必滅"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["カムハブリ"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["秘"] = { class = WSClass.Melee, default = WSDefault.Critical }
  WSAttrs["瞬"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["是生滅法"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["壱之太刀・燕飛"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["弐之太刀・鋒縛"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["参之太刀・轟天"] = { class = WSClass.HybridMelee, elem = WSElem.Lightning, default = WSDefault.Damage }
  WSAttrs["四之太刀・陽炎"] = { class = WSClass.HybridMelee, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["五之太刀・陣風"] = { class = WSClass.HybridMelee, elem = WSElem.Wind, default = WSDefault.Damage }
  WSAttrs["六之太刀・光輝"] = { class = WSClass.HybridMelee, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["七之太刀・雪風"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["八之太刀・月光"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["九之太刀・花車"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["十一之太刀・鳳蝶"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["盛夏之太刀・西瓜割"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["零之太刀・回天"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["十之太刀・乱鴉"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["祖之太刀・不動"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["十二之太刀・照破"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["絶之太刀・無名"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["シャインストライク"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["セラフストライク"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["ブレインシェイカー"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["スターライト"] = { class = WSClass.None, default = WSDefault.Damage }
  WSAttrs["ムーンライト"] = { class = WSClass.None, default = WSDefault.Damage }
  WSAttrs["スカルブレイカー"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["トゥルーストライク"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ジャッジメント"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ヘキサストライク"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["ブラックヘイロー"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["フラッシュノヴァ"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["ランドグリース"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ミスティックブーン"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ダガン"] = { class = WSClass.None, default = WSDefault.Damage }
  WSAttrs["レルムレイザー"] = { class = WSClass.Melee, default = WSDefault.Multi }
  WSAttrs["エクズデーション"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ダグダ"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["スターバースト"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ロッククラッシャー"] = { class = WSClass.Magical, elem = WSElem.Earth, default = WSDefault.Damage }
  WSAttrs["アースクラッシャー"] = { class = WSClass.Magical, elem = WSElem.Earth, default = WSDefault.Damage }
  -- TODO: Support randomize Light or Dark element.
  WSAttrs["スターバースト"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["サンバースト"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["シェルクラッシャー"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["フルスイング"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["スピリットテーカー"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["レトリビューション"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["カタクリスム"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["タルタロスゲート"] = { class = WSClass.Melee, default = WSDefault.Damage }
  WSAttrs["ヴィゾフニル"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Debuf }
  WSAttrs["ガーランドオブブリス"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Debuf }
  WSAttrs["オムニシエンス"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Debuf }
  WSAttrs["タルタロストーパー"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["ミルキル"] = { class = WSClass.None, default = WSDefault.Damage }
  WSAttrs["シャッターソウル"] = { class = WSClass.Melee, default = WSDefault.Debuf }
  WSAttrs["オシャラ"] = { class = WSClass.Melee, default = WSDefault.Damage }

  WSAttrs["フレイミングアロー"] = { class = WSClass.HybridRanged, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["ピアシングアロー"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ダリングアロー"] = { class = WSClass.Ranged, default = WSDefault.Critical }
  WSAttrs["サイドワインダー"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ブラストアロー"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["アーチングアロー"] = { class = WSClass.Ranged, default = WSDefault.Critical }
  WSAttrs["エンピリアルアロー"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["リフルジェントアロー"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["南無八幡"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ジシュヌの光輝"] = { class = WSClass.Ranged, default = WSDefault.Multi }
  WSAttrs["エイペクスアロー"] = { class = WSClass.Ranged, default = WSDefault.Damahe }
  WSAttrs["シャルヴ"] = { class = WSClass.Ranged, default = WSDefault.Damage }

  WSAttrs["ホットショット"] = { class = WSClass.HybridRanged, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["スプリットショット"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["スナイパーショット"] = { class = WSClass.Ranged, default = WSDefault.Critical }
  WSAttrs["スラッグショット"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ブラストショット"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ヘヴィショット"] = { class = WSClass.Ranged, default = WSDefault.Critical }
  WSAttrs["デトネーター"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["ナビングショット"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["カラナック"] = { class = WSClass.Ranged, default = WSDefault.Damage }
  WSAttrs["トゥルーフライト"] = { class = WSClass.Magical, elem = WSElem.Light, default = WSDefault.Damage }
  WSAttrs["レデンサリュート"] = { class = WSClass.Magical, elem = WSElem.Dark, default = WSDefault.Damage }
  WSAttrs["ワイルドファイア"] = { class = WSClass.Magical, elem = WSElem.Fire, default = WSDefault.Damage }
  WSAttrs["ラストスタンド"] = { class = WSClass.Ranged, default = WSDefault.Multi }
  WSAttrs["ジ・エンド"] = { class = WSClass.Ranged, default = WSDefault.Damage }
end
