class RelationshipsController < ApplicationController
  before_action :logged_in_employee

  def create
    @employee = Employee.find(params[:followed_id])
    current_employee.follow(@employee)
    respond_to do |format|
      format.html { redirect_to @employee }
      format.js
    end
  end

  def destroy
    @employee = Relationship.find(params[:id]).followed
    current_employee.unfollow(@employee)
    respond_to do |format|
      format.html { redirect_to @employee }
      format.js
    end
  end
end
