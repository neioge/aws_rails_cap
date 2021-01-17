class Employee < ApplicationRecord
  
  # FAQは従業員に依存させない 管理者がいなくなってもFAQは残す必要があるから。
  has_many :reports, dependent: :destroy
  has_many :faqs
  
  # チャット
  has_many :messages, dependent: :destroy
  
  attr_accessor :remember_token

  # 名前とメールアドレスについて
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  
  # パスワードについて
  # 編集アクションのために、パスワードの空白を許す。新規作成時はhas_secure_passwordが反映されるので問題ない。
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  # オブジェクトを必要としないメソッドは、モデルに記述する。他のファイルで簡単に参照できるようになる。
  
  # 渡された文字列のハッシュ値を返す
  def Employee.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def Employee.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = Employee.new_token
    update_attribute(:remember_digest, Employee.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # 試作feedの定義
  # 完全な実装は次章の「ユーザーをフォローする」を参照
  def timeline
    Report.where("employee_id = ?", id)
  end
  

end

# 自分用メモ
# attr_accessorはプロパティ、initializeメソッドはコンストラクタ、という意味だと思う。
# プロパティを設定することで、「データベースには保存しないけど、オブジェクトに紐付けて保存したいデータ」を管理できる。
# また、クラス内で定義するメソッドでは、アクセサーで生み出した仮想的属性を利用する場合は、selfをつけて明示する必要がある
# アップデートアトリビュートは.saveと違い、カラムだけ更新する、という意味？