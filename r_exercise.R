# =====================================
# R基礎演習 - 大学2年生向け
# RStudio Cloud対応版
# =====================================

# 図の日本語表示用
par(family = "Meiryo") #Windows
par(family= "HiraKakuProN-W3") #Mac

# 1. 基本的な操作とコンソールの使い方
# =====================================

# Rをコンソールとして使う
print("Rの基礎演習を開始します！")

# 変数への代入
x <- 10
y <- 5
name <- "統計学"

# 変数の表示
x
y
name

# 2. 四則演算
# =====================================

# 基本的な計算
addition <- 10 + 5        # 足し算
subtraction <- 10 - 5     # 引き算
multiplication <- 10 * 5  # 掛け算
division <- 10 / 5        # 割り算
power <- 10^2             # べき乗
remainder <- 10 %% 3      # 余り

# 結果の表示
print(paste("足し算:", addition))
print(paste("引き算:", subtraction))
print(paste("掛け算:", multiplication))
print(paste("割り算:", division))
print(paste("べき乗:", power))
print(paste("余り:", remainder))

# 3. ダミーデータの作成について
# =====================================

# 注意: student_data.csvはすでにリポジトリに含まれています
# 以下のコードは参考として残していますが、実行は不要です

# 乱数シードを設定（結果を再現可能にするため）
# set.seed(123)

# 学生データを作成
# n_students <- 100

# student_data <- data.frame(
#   student_id = 1:n_students,
#   age = sample(18:25, n_students, replace = TRUE),
#   gender = sample(c("男性", "女性"), n_students, replace = TRUE),
#   major = sample(c("経済学部", "工学部", "文学部", "理学部"), n_students, replace = TRUE),
#   math_score = round(rnorm(n_students, mean = 70, sd = 15), 1),
#   english_score = round(rnorm(n_students, mean = 65, sd = 12), 1),
#   study_hours = round(runif(n_students, min = 0, max = 8), 1)
# )

# データの確認
# head(student_data)
# str(student_data)

# CSVファイルとして保存
# write.csv(student_data, "student_data.csv", row.names = FALSE, fileEncoding = "UTF-8")

print("student_data.csvファイルを使用します（すでに用意されています）")

# 4. CSVファイルの読み込み
# =====================================

# CSVファイルを読み込み
data <- read.csv("student_data.csv", fileEncoding = "UTF-8")

# データの基本情報を確認
print("=== データの基本情報 ===")
print(dim(data))  # 行数と列数
print(summary(data))  # 基本統計量

# 5. 基本統計量の計算
# =====================================

print("=== 数学スコアの基本統計量 ===")

# 平均
math_mean <- mean(data$math_score)
print(paste("平均:", math_mean))

# 分散
math_var <- var(data$math_score)
print(paste("分散:", math_var))

# 標準偏差
math_sd <- sd(data$math_score)
print(paste("標準偏差:", math_sd))

# 中央値
math_median <- median(data$math_score)
print(paste("中央値:", math_median))

print("=== 英語スコアの基本統計量 ===")

# 英語スコアについても同様に計算
eng_mean <- mean(data$english_score)
eng_var <- var(data$english_score)
eng_sd <- sd(data$english_score)
eng_median <- median(data$english_score)

print(paste("平均:", eng_mean))
print(paste("分散:", eng_var))
print(paste("標準偏差:", eng_sd))
print(paste("中央値:", eng_median))

# 6. グラフの作成
# =====================================

# ヒストグラムの作成
print("=== ヒストグラムの作成 ===")

# 数学スコアのヒストグラム
hist(data$math_score,
     main = "数学スコアの分布",
     xlab = "数学スコア",
     ylab = "頻度",
     col = "lightblue",
     breaks = 15)

# 平均線を追加
abline(v = math_mean, col = "red", lwd = 2, lty = 2)
legend("topright", legend = paste("平均 =", round(math_mean, 1)), 
       col = "red", lty = 2, lwd = 2)

# 英語スコアのヒストグラム
hist(data$english_score,
     main = "英語スコアの分布",
     xlab = "英語スコア",
     ylab = "頻度",
     col = "lightgreen",
     breaks = 15)

# 平均線を追加
abline(v = eng_mean, col = "red", lwd = 2, lty = 2)
legend("topright", legend = paste("平均 =", round(eng_mean, 1)), 
       col = "red", lty = 2, lwd = 2)

# 箱ひげ図の作成
print("=== 箱ひげ図の作成 ===")

# 数学と英語スコアの箱ひげ図を並べて表示
boxplot(data$math_score, data$english_score,
        names = c("数学", "英語"),
        main = "数学と英語スコアの箱ひげ図",
        ylab = "スコア",
        col = c("lightblue", "lightgreen"))

# 学部別数学スコアの箱ひげ図
boxplot(math_score ~ major, data = data,
        main = "学部別数学スコアの箱ひげ図",
        xlab = "学部",
        ylab = "数学スコア",
        col = c("red", "blue", "green", "orange"),
        las = 2)

# 散布図の作成
print("=== 散布図の作成 ===")
plot(data$math_score, data$english_score,
     main = "数学と英語のスコア関係",
     xlab = "数学スコア",
     ylab = "英語スコア",
     col = "blue",
     pch = 16)

# 回帰直線を追加
abline(lm(english_score ~ math_score, data = data), col = "red", lwd = 2)

# 7. グループごとの棒グラフ
# =====================================

print("=== グループ別分析 ===")

# 学部別の平均スコア計算
major_math_mean <- aggregate(math_score ~ major, data = data, FUN = mean)
major_eng_mean <- aggregate(english_score ~ major, data = data, FUN = mean)

print("学部別数学平均スコア:")
print(major_math_mean)

print("学部別英語平均スコア:")
print(major_eng_mean)

# 学部別数学スコア棒グラフ
barplot(major_math_mean$math_score,
        names.arg = major_math_mean$major,
        main = "学部別数学平均スコア",
        ylab = "平均スコア",
        col = c("red", "blue", "green", "orange"),
        las = 2)  # x軸ラベルを縦にする

# 学部別英語スコア棒グラフ
barplot(major_eng_mean$english_score,
        names.arg = major_eng_mean$major,
        main = "学部別英語平均スコア",
        ylab = "平均スコア",
        col = c("red", "blue", "green", "orange"),
        las = 2)

# 性別による比較
gender_math_mean <- aggregate(math_score ~ gender, data = data, FUN = mean)
gender_eng_mean <- aggregate(english_score ~ gender, data = data, FUN = mean)

print("性別数学平均スコア:")
print(gender_math_mean)

print("性別英語平均スコア:")
print(gender_eng_mean)

# 性別比較の棒グラフ
par(mfrow = c(1, 2))  # 1行2列のレイアウト

barplot(gender_math_mean$math_score,
        names.arg = gender_math_mean$gender,
        main = "性別数学平均スコア",
        ylab = "平均スコア",
        col = c("pink", "lightblue"))

barplot(gender_eng_mean$english_score,
        names.arg = gender_eng_mean$gender,
        main = "性別英語平均スコア",
        ylab = "平均スコア",
        col = c("pink", "lightblue"))

par(mfrow = c(1, 1))  # レイアウトをリセット

# 8. 相関係数の計算
# =====================================

print("=== 相関分析 ===")

# 数学と英語スコアの相関係数
correlation_math_eng <- cor(data$math_score, data$english_score)
print(paste("数学と英語スコアの相関係数:", correlation_math_eng))

# 勉強時間と各スコアの相関
correlation_study_math <- cor(data$study_hours, data$math_score)
correlation_study_eng <- cor(data$study_hours, data$english_score)

print(paste("勉強時間と数学スコアの相関係数:", correlation_study_math))
print(paste("勉強時間と英語スコアの相関係数:", correlation_study_eng))

# 相関行列の作成
numeric_data <- data[, c("math_score", "english_score", "study_hours", "age")]
correlation_matrix <- cor(numeric_data)

print("相関行列:")
print(round(correlation_matrix, 3))

# 相関の強さを判定する関数
interpret_correlation <- function(r) {
  abs_r <- abs(r)
  if (abs_r >= 0.7) {
    return("強い相関")
  } else if (abs_r >= 0.4) {
    return("中程度の相関")
  } else if (abs_r >= 0.2) {
    return("弱い相関")
  } else {
    return("ほとんど相関なし")
  }
}

print(paste("数学と英語の相関の強さ:", interpret_correlation(correlation_math_eng)))

# 9. 追加の分析練習
# =====================================

print("=== 追加分析 ===")

# 条件付き統計
high_performers <- data[data$math_score >= 80, ]
print(paste("数学80点以上の学生数:", nrow(high_performers)))
print(paste("高得点者の英語平均スコア:", mean(high_performers$english_score)))

# クロス集計
major_gender_table <- table(data$major, data$gender)
print("学部別性別クロス集計:")
print(major_gender_table)

# 10. まとめとレポート
# =====================================

print("=== 分析結果まとめ ===")
print(paste("総学生数:", nrow(data)))
print(paste("数学平均点:", round(math_mean, 1), "点"))
print(paste("英語平均点:", round(eng_mean, 1), "点"))
print(paste("数学と英語の相関:", round(correlation_math_eng, 3)))
print(paste("最も数学平均の高い学部:", major_math_mean$major[which.max(major_math_mean$math_score)]))

print("演習完了！お疲れさまでした。")

# =====================================
# 練習問題（コメントアウト状態）
# 学生が自分で試すための課題
# =====================================

# 【練習問題1】
# 年齢別の平均スコアを計算してみましょう
# age_math_mean <- aggregate(math_score ~ age, data = data, FUN = mean)

# 【練習問題2】
# 勉強時間が4時間以上の学生だけを抽出してみましょう
# high_study_students <- data[data$study_hours >= 4, ]

# 【練習問題3】
# 数学と英語の合計点を新しい列として追加してみましょう
# data$total_score <- data$math_score + data$english_score

# 【練習問題4】
# 学部別の勉強時間の平均を計算してみましょう
# major_study_mean <- aggregate(study_hours ~ major, data = data, FUN = mean)