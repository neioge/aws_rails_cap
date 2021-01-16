class Message < ApplicationRecord
  belongs_to :employee
  validates :employee_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  # 投稿されたメッセージをメッセージ用の部分テンプレートでHTMLに変換
  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end
end
