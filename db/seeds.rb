# This file should contain all the record creation needed to seed the database with its default values.
# このファイルには、データベースにデフォルト値をシードするために必要なすべてのレコード作成が含まれている必要があります。
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# 次に、rails db：seedコマンドを使用してデータをロードできます（またはdb：setupを使用してデータベースと一緒に作成できます）。

# 例：
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# メインのサンプル従業員を1人作成する
Employee.create!(name:  "FA Q太郎",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加の従業員をまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  Employee.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# ユーザーの一部を対象にマイクロポストを生成する
employees = Employee.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 30)
  employees.each { |employee| employee.reports.create!(content: content) }
end

# ユーザーの一部を対象にメッセージを生成する
employees = Employee.order(:created_at).take(6)
1000.times do
  content = Faker::Lorem.sentence(word_count: 10)
  employees.each { |employee| employee.messages.create!(content: content) }
end

# ユーザーの一部を対象にFAQを生成する
employees = Employee.order(:created_at).take(6)
50.times do
  question = Faker::Lorem.sentence(word_count: 20)
  answer = Faker::Lorem.sentence(word_count: 20)
  employees.each { |employee| employee.faqs.create!(question: question, answer: answer) }
end