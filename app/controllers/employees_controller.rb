class EmployeesController < ApplicationController
  def new
  end
  
  def show
    @employee = Employee.find(params[:id])
  end
  
  def new
    @employee = Employee.new
  end
  
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = "FAQ管理システムへようこそ"
      redirect_to @employee
    else
      render 'new'  # renderメソッドはコントローラ内でも使用でき、該当のアクションをそのまま呼び出せる。
    end
  end
  
  private

    def employee_params
      params.require(:employee).permit(:name, :email, :password, :password_confirmation)
    end
  
end
