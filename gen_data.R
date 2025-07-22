# exerceseのための架空のデータを生成するスクリプト
# このスクリプトは、Rの演習用に架空のデータを生成します。

###########################################################
#### r_exerecise_1.Rに使用するstudent_data.csvデータ  ####
# 乱数シードを設定（結果を再現可能にするため）
set.seed(123)

# 学生データを作成
n_students <- 100

student_data <- data.frame(
  student_id = 1:n_students,
  age = sample(18:25, n_students, replace = TRUE),
  gender = sample(c("男性", "女性"), n_students, replace = TRUE),
  major = sample(c("経済学部", "工学部", "文学部", "理学部"), n_students, replace = TRUE),
  math_score = round(rnorm(n_students, mean = 70, sd = 15), 1),
  english_score = round(rnorm(n_students, mean = 65, sd = 12), 1),
  study_hours = round(runif(n_students, min = 0, max = 8), 1)
)

# データの確認
head(student_data)
str(student_data)

# CSVファイルとして保存
write.csv(student_data, "data/student_data.csv", row.names = FALSE, fileEncoding = "UTF-8")

###########################################################
#### r_exercise_2.Rに使用するlifestyle_data.csvデータを作成####
# ランダムシードを設定
set.seed(12345)

# サンプルサイズ
n <- 100

# データフレームを作成
lifestyle_data <- data.frame(
  id = 1:n,
  age = sample(22:45, n, replace = TRUE),
  gender = sample(c("女性", "男性"), n, replace = TRUE, prob = c(0.5, 0.5)),
  education = sample(c("大卒", "非大卒"), n, replace = TRUE, prob = c(0.65, 0.35)),
  income = round(rnorm(n, mean = 550, sd = 120)),
  married = sample(c(0, 1), n, replace = TRUE, prob = c(0.45, 0.55)),
  life_satisfaction = sample(1:5, n, replace = TRUE, prob = c(0.05, 0.25, 0.35, 0.30, 0.05)),
  mental_health = sample(1:5, n, replace = TRUE, prob = c(0.02, 0.28, 0.35, 0.33, 0.02))
)

# 収入の調整（負の値を修正）
lifestyle_data$income[lifestyle_data$income < 200] <- sample(200:400, sum(lifestyle_data$income < 200), replace = TRUE)

write.csv(lifestyle_data, "data/lifestyle_data.csv", row.names = FALSE, fileEncoding = "UTF-8")
###########################################################