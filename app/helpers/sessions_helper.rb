module SessionsHelper
  
  def log_in(employee)
    session[:employee_id] = employee.id
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_employee)
    session.delete(:employee_id)
    @current_employee = nil
  end

  # クッキーズの保存と破棄
  def remember(employee)
    employee.remember
    cookies.permanent.signed[:employee_id] = employee.id
    cookies.permanent[:remember_token] = employee.remember_token
  end
  def forget(employee)
    employee.forget
    cookies.delete(:employee_id)
    cookies.delete(:remember_token)
  end
  
  # チュートリアルに「他従業員を編集・削除できるようにする」という機能をつけても、重要になる。
  # いいね機能なら、likesコントローラのCRUDアクションで、現在の従業員を渡す必要がある。
  def current_employee
    if (employee_id = session[:employee_id])
      @current_employee ||= Employee.find_by(id: employee_id)
    elsif (employee_id = cookies.signed[:employee_id])
      employee = Employee.find_by(id: employee_id)
      if employee && employee.authenticated?(cookies[:remember_token])
        log_in employee
        @current_employee = employee
      end
    end    
  end
  
  # 渡されたユーザーがカレントユーザーであればtrueを返す
  # 導入したタイミング（他の従業員の情報を編集できないようにするため）は、今後使わないので、このヘルパーも使わないと思われる。
  # と思ったけど、フォローボタンやいいねをするとき、自分か自分以外か、という判断が必要になるので、使うかも。
  def current_employee?(employee)
    employee && employee == current_employee
  end
  
  # わかりやすいヘルパーだけど、現在の「ヘッダーの各機能の表示」の判断くらいでしか使わない気がする。チュートリアルと変わらない。
  def logged_in?
    !current_employee.nil?
  end
  
  # フレンドリーフォワーディングのセット
  # 演算子||は、「nilでなければ最初の引数を、nilであればデフォルトを評価する」という
  # リダイレクト後にセッション内のURLを消しておかないと、再ログインした際にまた求めてもいないURLにフォワーディングされてしまうから
  # ゲット送信に限定をする理由は、POST送信を期待するURLにGET送信をしてエラーが発生する可能性があるから。
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end

# 学習メモ
# current_userでは、まずセッションにユーザーのIDが存在すればそれを優先的に取得して現在のユーザーを返す。
# セッションになければ、クッキーズから暗号化したIDとパスワードを取得して、該当のユーザーを探して返す。