class SessionsController < ApplicationController
  def new
  end
  
  def create
    employee = Employee.find_by(email: params[:session][:email].downcase)
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      params[:session][:remember_me] == '1' ? remember(employee) : forget(employee)
      redirect_to employee
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
