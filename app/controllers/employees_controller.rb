class EmployeesController < ApplicationController

  # ログインしていない従業員を弾く。この後、URLの中身にnew createも追加すると思う。
  # ログドインユーザーはフレンドリーフォワーディングに使われるけど、あとでshow・createにも適用する必要がある。（createはむりだが）
  before_action :logged_in_employee, only: [:index, :edit, :update, :destroy, :following, :followers]
  
  # こちらは今後消す予定。代わりに、「現在の従業員が管理者権限を持っていればエディット画面を返す」←これは、したのやつでできる
  before_action :correct_employee,   only: [:edit, :update]
  
  # こちらは、管理者を増やした場合でも必要。エディットとアップデートを加える予定。
  before_action :admin_employee,     only: :destroy

  def destroy
    employee = Employee.find(params[:id])
    name_for_flash = employee.name
    employee.destroy
    flash[:success] = "従業員　" + name_for_flash + "　を削除しました"
    redirect_to employees_url
  end
  
  # パラメータがnilなら１ページ目を出すようになっている。
  def index
    @employees = Employee.paginate(page: params[:page])
  end

  def show
    @employee = Employee.find(params[:id])
    @reports = @employee.reports.paginate(page: params[:page])
  end
  
  # 従業員のサインイン画面を表示する。残す。現時点ではビフォアアクションで弾かれないが、あとで弾くように変更する。
  # リンク元：従業員Indexビューの一番上に「新規登録ボタン」を配置する
  # 現在のリンク元：Homeビューの画面中央のボタンは、「ログイン」ボタンに変更しようと思う。
  def new
    @employee = Employee.new
  end
  
  # サインイン画面からPOST送信された情報を基に従業員情報を登録、フラッシュと共に従業員の詳細画面へリダイレクトする。
  # こちらも現在はビフォアアクションで弾かれないが、後ほど弾くようにする。
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      log_in @employee
      flash[:success] = "FAQ管理システムへようこそ"
      redirect_to @employee
    else
      render 'new'  # renderメソッドはコントローラ内でも使用でき、該当のアクションをそのまま呼び出せる。
    end
  end

  # 従業員の編集画面を表示する。現時点でも、別に現在の従業員に限定するロジックではないので、このままでいいと思う。
  # <%= link_to "編集", edit_employee_path(@employee) %>をemployees/showに配置で問題ない？要実験。
  # また、そのボタンは管理者じゃないと表示しない、というロジックも必要。
  # deleteボタンはインデックス画面に表示しているので、同じように編集ボタンがあってもいいと思う。
  def edit
    @employee = Employee.find(params[:id])
  end
  
  # ここも、チュートリアル通りでいいと思う。
  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      flash[:success] = "従業員　" + @employee.name + "　の情報を更新しました"
      redirect_to @employee
    else
      render 'edit'
    end
  end
  
  def following
    @title = "フォロー"
    @employee  = Employee.find(params[:id])
    @employees = @employee.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @employee  = Employee.find(params[:id])
    @employees = @employee.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
    
    # パラメータの数と種類を限定することで、例えば管理者権限などのパラメータを含ませて送信されることを防げる。
    # PATCH送信で管理者権限を送信されないようにするため、現在はadminを含んでいない。
    # ただ、ここにadminを含めないと、管理者による管理者の生産、ができないので、セキュリティを犠牲にしてadminを追加しよう思う。
    def employee_params
      params.require(:employee).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeアクション

    # ログイン済みユーザーかどうか確認　ついでにフレフォのためにリクエスト先をヘルパーを使って保存する
    # アプリケーションコントローラに配置して、全てのコントローラで使えるようにした。FAQでも使うことができる。
    # def logged_in_employee
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "ログインをしてください"
    #     redirect_to login_url
    #   end
    # end
    
    # 正しいユーザーかどうか確認 今後消す予定。代わりに、「その従業員が管理者権限を持っていれば編集画面を返す」を用意。
    def correct_employee
      @employee = Employee.find(params[:id])
      redirect_to(root_url) unless current_employee?(@employee)
    end
    
    # 管理者かどうか確認
    def admin_employee
      redirect_to(root_url) unless current_employee.admin?
    end
  
end
