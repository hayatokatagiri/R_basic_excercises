# =====================================
# R基礎演習 - 大学生向け
# RStudio Cloud対応版
# 内容：Rの基本操作、データの読み込み、基本統計量の計算、グラフ作成
# =====================================

# 図の日本語表示用
#par(family = "Meiryo") #Windows
#par(family= "HiraKakuProN-W3") #Mac

# 基本的な操作とコンソールの使い方
# =====================================

# Rをコンソールとして使う
print("Hello World!")

# コメントアウト（#で始まる行は実行されません）

# 基本的な計算
10 + 5        # 足し算
10 - 5     # 引き算
10 * 5  # 掛け算
10 / 5        # 割り算
10^2             # べき乗
10 %% 3      # 余り


# 変数への代入
x <- 10
y <- 5
name <- "統計学"

# 変数の表示
x
y
name

x + y  # 変数同士の計算

# CSVファイルの読み込み
data <- read.csv("./data/student_data.csv", fileEncoding = "UTF-8")

# データの基本情報を確認
print("=== データの基本情報 ===")
print(dim(data))  # 行数と列数
print(names(data))  # 変数名
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

# 基本統計量の表示
summary(data$math)

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

# 基本統計量の表示
summary(data$eng)

#クロス集計
table(data$major, data$gender) #男女X専攻
round(prop.table(table(data$major, data$gender), margin = 1) * 100, 1) #男女X専攻の割合

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

# 相関係数
cor_math_eng <- cor(data$math_score, data$english_score)
cor_studyh_math <- cor(data$study_hours, data$math_score)
cor_studyh_eng <- cor(data$study_hours, data$english_score)

# グループごとの棒グラフ
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