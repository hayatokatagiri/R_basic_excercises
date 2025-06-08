# =============================================================================
# R基礎演習 - 第2回: 回帰分析
# 対象: 大学生向け統計学習
# 内容: 単回帰分析、重回帰分析、ロジスティック回帰分析
# =============================================================================

# 作業環境のクリア
rm(list = ls())

# 図の日本語表示用
#par(family = "Meiryo") #Windows
#par(family= "HiraKakuProN-W3") #Mac

print("=== R回帰分析演習を開始します ===")

# =============================================================================
# 1. データの読み込みと確認
# =============================================================================

print("=== 1. データの読み込み ===")

# CSVファイルの読み込み
data <- read.csv("data/lifestyle_data.csv", fileEncoding = "UTF-8")

# データの基本情報を確認
print("データの行数と列数:")
print(dim(data))

print("データの最初の6行:")
print(head(data))

print("データの構造:")
print(str(data))

print("データの基本統計量:")
print(summary(data))

# =============================================================================
# 2. データの前処理
# =============================================================================

print("=== 2. データの前処理 ===")

# カテゴリカル変数をファクター型に変換
data$gender <- as.factor(data$gender)
data$education <- as.factor(data$education)

# 欠損値の確認
print("欠損値の確認:")
print(colSums(is.na(data)))

# 既婚状況の分布確認
print("既婚状況の分布:")
print(table(data$married))
print("既婚率:")
print(prop.table(table(data$married)))

# =============================================================================
# 3. 記述統計とデータ可視化
# =============================================================================

print("=== 3. 記述統計とデータ可視化 ===")

# 年齢の分布
print("年齢の基本統計量:")
print(summary(data$age))

hist(data$age, 
     main = "年齢の分布", 
     xlab = "年齢", 
     ylab = "度数",
     col = "lightblue",
     breaks = 10)

# 年収の分布
print("年収の基本統計量:")
print(summary(data$income))

hist(data$income, 
     main = "年収の分布", 
     xlab = "年収（万円）", 
     ylab = "度数",
     col = "lightgreen",
     breaks = 15)

# 生活満足度の分布
print("生活満足度の基本統計量:")
print(table(data$life_satisfaction))

barplot(table(data$life_satisfaction),
        main = "生活満足度の分布",
        xlab = "生活満足度（1-5）",
        ylab = "人数",
        col = "orange")

# グループ別の年収比較
print("性別による年収の違い:")
print(by(data$income, data$gender, summary))

boxplot(income ~ gender, data = data,
        main = "性別による年収の比較",
        xlab = "性別",
        ylab = "年収（万円）",
        col = c("pink", "lightblue"))

print("学歴による年収の違い:")
print(by(data$income, data$education, summary))

boxplot(income ~ education, data = data,
        main = "学歴による年収の比較",
        xlab = "学歴",
        ylab = "年収（万円）",
        col = c("orange", "purple"))

# 既婚状況別の比較
print("既婚状況による年収の違い:")
married_labels <- c("未婚・離死別", "既婚")
boxplot(income ~ married, data = data,
        main = "既婚状況による年収の比較",
        xlab = "既婚状況",
        ylab = "年収（万円）",
        names = married_labels,
        col = c("lightcoral", "lightgreen"))

print("既婚状況による年齢の違い:")
boxplot(age ~ married, data = data,
        main = "既婚状況による年齢の比較",
        xlab = "既婚状況",
        ylab = "年齢",
        names = married_labels,
        col = c("lightcoral", "lightgreen"))

# =============================================================================
# 4. 相関分析
# =============================================================================

print("=== 4. 相関分析 ===")

# 数値変数間の相関行列
correlation_vars <- c("age", "income", "life_satisfaction", "mental_health", "married")
cor_matrix <- cor(data[correlation_vars])

print("相関行列:")
print(round(cor_matrix, 3))

# 散布図行列
pairs(data[correlation_vars],
      main = "数値変数間の散布図行列")

# 個別の散布図
plot(data$age, data$income,
     main = "年齢と年収の関係",
     xlab = "年齢",
     ylab = "年収（万円）",
     pch = 16,
     col = "blue")

plot(data$income, data$life_satisfaction,
     main = "年収と生活満足度の関係",
     xlab = "年収（万円）",
     ylab = "生活満足度",
     pch = 16,
     col = "red")

plot(data$age, data$married,
     main = "年齢と既婚状況の関係",
     xlab = "年齢",
     ylab = "既婚状況（0=未婚・離死別, 1=既婚）",
     pch = 16,
     col = "green")

plot(data$life_satisfaction, data$mental_health,
     main = "生活満足度と精神的健康の関係",
     xlab = "生活満足度",
     ylab = "精神的健康",
     pch = 16,
     col = "purple")

# =============================================================================
# 5. 単回帰分析
# =============================================================================

print("=== 5. 単回帰分析 ===")

# 5.1 年齢と年収の単回帰
print("5.1 年齢 → 年収の単回帰分析")

model1 <- lm(income ~ age, data = data)
print(summary(model1))

# 回帰直線の描画
plot(data$age, data$income,
     main = "年齢と年収の回帰分析",
     xlab = "年齢",
     ylab = "年収（万円）",
     pch = 16,
     col = "blue")
abline(model1, col = "red", lwd = 2)

# 回帰式の表示
coef1 <- coef(model1)
equation1 <- paste("年収 =", round(coef1[1], 2), "+", round(coef1[2], 2), "× 年齢")
print(paste("回帰式:", equation1))

# 決定係数
r_squared1 <- summary(model1)$r.squared
print(paste("決定係数 (R²):", round(r_squared1, 3)))

# 5.2 年収と生活満足度の単回帰
print("5.2 年収 → 生活満足度の単回帰分析")

model2 <- lm(life_satisfaction ~ income, data = data)
print(summary(model2))

plot(data$income, data$life_satisfaction,
     main = "年収と生活満足度の回帰分析",
     xlab = "年収（万円）",
     ylab = "生活満足度",
     pch = 16,
     col = "red")
abline(model2, col = "blue", lwd = 2)

coef2 <- coef(model2)
equation2 <- paste("生活満足度 =", round(coef2[1], 3), "+", round(coef2[2], 6), "× 年収")
print(paste("回帰式:", equation2))

r_squared2 <- summary(model2)$r.squared
print(paste("決定係数 (R²):", round(r_squared2, 3)))

# 5.3 年齢と生活満足度の単回帰
print("5.3 年齢 → 生活満足度の単回帰分析")

model3 <- lm(life_satisfaction ~ age, data = data)
print(summary(model3))

plot(data$age, data$life_satisfaction,
     main = "年齢と生活満足度の回帰分析",
     xlab = "年齢",
     ylab = "生活満足度",
     pch = 16,
     col = "green")
abline(model3, col = "red", lwd = 2)

coef3 <- coef(model3)
equation3 <- paste("生活満足度 =", round(coef3[1], 3), "+", round(coef3[2], 4), "× 年齢")
print(paste("回帰式:", equation3))

r_squared3 <- summary(model3)$r.squared
print(paste("決定係数 (R²):", round(r_squared3, 3)))

# =============================================================================
# 6. 重回帰分析
# =============================================================================

print("=== 6. 重回帰分析 ===")

# 6.1 年収を目的変数とする重回帰
print("6.1 年収を目的変数とする重回帰分析")

model4 <- lm(income ~ age + gender + education + married + life_satisfaction + mental_health, data = data)
print(summary(model4))

# モデルの比較（単回帰 vs 重回帰）
print("モデル比較（年収）:")
print(paste("年齢のみのR²:", round(summary(model1)$r.squared, 3)))
print(paste("重回帰のR²:", round(summary(model4)$r.squared, 3)))
print(paste("調整済みR²:", round(summary(model4)$adj.r.squared, 3)))

# 6.2 生活満足度を目的変数とする重回帰
print("6.2 生活満足度を目的変数とする重回帰分析")

model5 <- lm(life_satisfaction ~ age + gender + education + married + income + mental_health, data = data)
print(summary(model5))

print("モデル比較（生活満足度）:")
print(paste("年収のみのR²:", round(summary(model2)$r.squared, 3)))
print(paste("年齢のみのR²:", round(summary(model3)$r.squared, 3)))
print(paste("重回帰のR²:", round(summary(model5)$r.squared, 3)))
print(paste("調整済みR²:", round(summary(model5)$adj.r.squared, 3)))

# 6.3 精神的健康を目的変数とする重回帰
print("6.3 精神的健康を目的変数とする重回帰分析")

model6 <- lm(mental_health ~ age + gender + education + married + income + life_satisfaction, data = data)
print(summary(model6))

print(paste("精神的健康モデルの調整済みR²:", round(summary(model6)$adj.r.squared, 3)))

# 残差分析
print("残差分析:")
par(mfrow = c(2, 2))
plot(model4, main = "年収モデルの診断")
par(mfrow = c(1, 1))

# =============================================================================
# 7. ロジスティック回帰分析
# =============================================================================

print("=== 7. ロジスティック回帰分析 ===")

# 7.1 既婚状況を目的変数とするロジスティック回帰
print("7.1 既婚状況を目的変数とするロジスティック回帰")

logit_model1 <- glm(married ~ age + gender + education + income + life_satisfaction + mental_health, 
                    data = data, family = binomial)
print(summary(logit_model1))

# オッズ比の計算
odds_ratios <- exp(coef(logit_model1))
print("オッズ比:")
print(round(odds_ratios, 3))

# 7.2 生活満足度高群を目的変数とするロジスティック回帰
print("7.2 生活満足度高群（4-5点）を目的変数とするロジスティック回帰")

# 生活満足度を二値化（4-5点を高群とする）
data$high_satisfaction <- ifelse(data$life_satisfaction >= 4, 1, 0)

print("生活満足度高群の分布:")
print(table(data$high_satisfaction))
print("生活満足度高群の割合:")
print(prop.table(table(data$high_satisfaction)))

logit_model2 <- glm(high_satisfaction ~ age + gender + education + married + income + mental_health, 
                    data = data, family = binomial)
print(summary(logit_model2))

odds_ratios2 <- exp(coef(logit_model2))
print("オッズ比:")
print(round(odds_ratios2, 3))

# 7.3 精神的健康高群を目的変数とするロジスティック回帰
print("7.3 精神的健康高群（4-5点）を目的変数とするロジスティック回帰")

data$high_mental_health <- ifelse(data$mental_health >= 4, 1, 0)

print("精神的健康高群の分布:")
print(table(data$high_mental_health))
print("精神的健康高群の割合:")
print(prop.table(table(data$high_mental_health)))

logit_model3 <- glm(high_mental_health ~ age + gender + education + married + income + life_satisfaction, 
                    data = data, family = binomial)
print(summary(logit_model3))

odds_ratios3 <- exp(coef(logit_model3))
print("オッズ比:")
print(round(odds_ratios3, 3))

# =============================================================================
# 9. 結果の解釈とまとめ
# =============================================================================

print("=== 9. 分析結果のまとめ ===")

print("【単回帰分析の結果】")
print(paste("年齢と年収の相関係数:", round(cor(data$age, data$income), 3)))
print(paste("年収と生活満足度の相関係数:", round(cor(data$income, data$life_satisfaction), 3)))
print(paste("年齢と生活満足度の相関係数:", round(cor(data$age, data$life_satisfaction), 3)))

print("【重回帰分析の結果】")
print(paste("年収モデルの調整済みR²:", round(summary(model4)$adj.r.squared, 3)))
print(paste("生活満足度モデルの調整済みR²:", round(summary(model5)$adj.r.squared, 3)))
print(paste("精神的健康モデルの調整済みR²:", round(summary(model6)$adj.r.squared, 3)))

print("【ロジスティック回帰の結果】")
print(paste("既婚状況予測の的中率:", round(accuracy_married, 3)))
print(paste("生活満足度高群予測の的中率:", round(accuracy_satisfaction, 3)))

# =============================================================================
# 10. 練習問題
# =============================================================================

print("=== 10. 練習問題 ===")

print("以下の分析を試してみましょう:")
print("1. 年齢を二次項（age^2）として含む重回帰分析")
print("2. 性別と既婚状況の交互作用項を含む年収の重回帰分析")
print("3. 年収を対数変換（log）して回帰分析")

# 練習問題1の解答例
print("【練習問題1の解答例】")
data$age_squared <- data$age^2
practice_model <- lm(income ~ age + age_squared + gender + education + married, data = data)
print(paste("二次項を含む年収モデルの調整済みR²:", round(summary(practice_model)$adj.r.squared, 3)))


print("=== 演習完了 ===")
print("お疲れ様でした！回帰分析の基礎を学習しました。")
print("結果を確認し、統計的有意性や効果の大きさを解釈してみましょう。")