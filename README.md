# Rによる統計学の基礎

## 概要

このリポジトリは、R統計解析の基礎を学習するための演習コードです。RStudio Cloudで実行することを前提としており、基本的なR操作から統計分析、データ可視化、回帰分析まで段階的に学習できます。
（大学生向けの授業資料として作成）
もちろん、デスクトップ版のRやPositronでも実行可能です。

## 資料
pdf: https://researchmap.jp/multidatabases/multidatabase_contents/download/763488/a59c9fd7c1137834f5039948d875d0c8/40975?col_no=2&frame_id=1399909

## 演習構成

### 1: R基礎と記述統計 (`r_exercise_1.R`)
- 基本操作とデータ型
- 四則演算
- データ操作（CSV読み込み・書き出し）
- 記述統計（平均、分散、標準偏差、中央値）
- データ可視化（ヒストグラム、箱ひげ図、散布図、棒グラフ）
- 相関分析

### 2: 回帰分析 (`r_exercise_2.R`)
- 単回帰分析
- 重回帰分析
- 回帰モデルの評価（決定係数、p値）
- ロジスティック回帰分析

## 使用方法

### RStudio Cloudでの実行手順

#### 1. RStudio Cloudにアクセス
1. [RStudio Cloud](https://rstudio.cloud/)にアクセス
2. アカウントでログイン（未登録の場合は新規登録）

#### 2. プロジェクトの作成
1. 「New Project」をクリック
2. 「New Project from Git Repository」を選択
3. このリポジトリのURL `https://github.com/hayatokatagiri/R_basic_excercises.git` を入力
4. 「OK」をクリック

#### 3. 演習の実行
1. ファイルパネルから `r_exercises_base.R` を開く
2. コード全体を選択（Ctrl+A / Cmd+A）
3. 「Run」ボタンをクリック、または Ctrl+Enter / Cmd+Enter で実行
4. 結果をConsoleパネルとPlotsパネルで確認

### ローカル環境での実行（参考）

RStudioがインストールされている場合：

```bash
# リポジトリのクローン
git clone https://github.com/hayatokatagiri/R_basic_excercises.git

# ディレクトリに移動
cd [R_basic_excercises]

# RStudioでr_exercise_1.Rを開いて実行
```
もしくはこのページの「<>Code」の「Download ZIP」からダウンロード

## Positronでの実行
File > New Folder from Git...　でこのリポジトリのURL `https://github.com/hayatokatagiri/R_basic_excercises.git` を入力

## ファイル構成

```
.
├── README.md
├── r_exercise_1.R
├── r_exercise_2.R
├── gen_data.R  # data/に演習用のデータを作成するスクリプト（実行する必要なし）
└── data/
    ├── student_data.csv    # 学生データ（演習1で使用）
    └── lifestyle_data.csv  # ライフスタイルデータ（演習2で使用）
```

## 演習の進め方

### 初回実行時
1. ファイルが正しく読み込まれることを確認
2. コード全体を一度実行して全体の流れを把握
3. 各セクションのコメントを読んで理解を深める
4. 生成されたグラフやデータを確認

### 詳細学習時
1. セクションごとにコードを実行
2. 変数の値や関数の結果を個別に確認
3. パラメータを変更して結果の違いを観察

### 発展学習
- コード末尾の練習問題にチャレンジ
- 新しい変数の作成
- 追加的な統計分析

## トラブルシューティング

### エラーが発生した場合
1. **パッケージ関連エラー**: 基本的なR関数のみを使用しているため、追加パッケージは不要
2. **ファイル読み込みエラー**: `student_data.csv` が./dataディレクトリにあることを確認
3. **文字化け**: 日本語が正しく表示されない場合は、RStudio Cloudの言語設定を確認

### 実行が途中で止まった場合
1. Consoleで赤いストップボタンをクリック
2. `rm(list=ls())` でワークスペースをクリア
3. 最初から再実行

## 参考資料

### R言語の基礎
- [R公式サイト](https://www.r-project.org/)
- [RStudio公式ドキュメント](https://docs.rstudio.com/)

## ライセンス

このプロジェクトは教育目的で作成されています。自由に使用、修正、配布していただけます。

## 質問・サポート

演習に関する質問は授業中またはオフィスアワーにお願いします。

---

**更新日**: 2025年7月22日  
**作成者**: Hayato KATAGIRI