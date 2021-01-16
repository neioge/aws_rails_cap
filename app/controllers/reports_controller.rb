class ReportsController < ApplicationController
  before_action :logged_in_employee, only: [:create, :destroy]

  def create
  end

  def destroy
  end
end
