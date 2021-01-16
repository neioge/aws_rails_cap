class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @report  = current_employee.reports.build
      @timeline_items = current_employee.timeline.paginate(page: params[:page])
    end
  end

  def about_me
  end
  
  def about_app
  end
  
  def contact
  end
end
