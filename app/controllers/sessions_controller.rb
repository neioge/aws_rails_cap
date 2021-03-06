class SessionsController < ApplicationController
  def new
  end
  
  # ややこしいのが、ルート「ログインのPOST送信先」が「セッションコントローラのクリエイトアクション」というところ
  def create
    employee = Employee.find_by(email: params[:session][:email].downcase)
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      params[:session][:remember_me] == '1' ? remember(employee) : forget(employee)
      flash[:success] = 'ログインしました'
      redirect_back_or employee
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  # ゲストログイン(FA Q太郎でログインしてもらう)
  def guest
    employee = Employee.find_by(id: 1)
    log_in employee
    remember(employee)
    redirect_back_or employee
  end
  
end
