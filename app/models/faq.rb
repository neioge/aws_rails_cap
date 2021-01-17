class Faq < ApplicationRecord
  # モデル作成時に、リファレンスを付けたのでデフォルトで書かれている。
  belongs_to :employee
  
  # データベースから情報を取得する際の、デフォルトの順番をきめることができる。
  default_scope -> { order(created_at: :desc) }
  
  validates :employee_id, presence: true
  validates :question, presence: true, length: { maximum: 500 }
  validates :answer, presence: true, length: { maximum: 500 }
  
  # 検索用のメソッド。
  def self.search(search)
    return Faq.all unless search
    Faq.where(['question LIKE ?', "%#{search}%"])
  end
end
