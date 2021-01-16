class Report < ApplicationRecord
  belongs_to :employee
  # 新しいものが最初に来るようにできる。FAQ検索などでも使うべき。
  default_scope -> { order(created_at: :desc) }
  validates :employee_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end

# 従業員テーブルと結合することで、下記のメソッドが使えるようになる。
# reports.employee	reportsに紐付いたEmployeeオブジェクトを返す
# employees.reports	employeesのマイクロポストの集合をかえす
# employees.reports.create(arg)	employeesに紐付いたマイクロポストを作成する
# employees.reports.create!(arg)	に紐付いたマイクロポストを作成する（失敗時に例外を発生）
# employees.reports.build(arg)	employeesに紐付いた新しいReportオブジェクトを返す
# employees.reports.find_by(id: 1)	employeeに紐付いていて、idが1であるマイクロポストを検索する