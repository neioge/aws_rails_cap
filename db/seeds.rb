# This file should contain all the record creation needed to seed the database with its default values.
# このファイルには、データベースにデフォルト値をシードするために必要なすべてのレコード作成が含まれている必要があります。
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# 次に、rails db：seedコマンドを使用してデータをロードできます（またはdb：setupを使用してデータベースと一緒に作成できます）。

# 例：
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# メインのサンプル従業員を1人作成する
Employee.create!(name:  "Example Employee",
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