class ApplicationController < ActionController::Base
  include SessionsHelper
  
   private

    # 従業員のログインを確認する
    def logged_in_employee
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
