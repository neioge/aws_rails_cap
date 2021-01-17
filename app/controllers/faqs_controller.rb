class FaqsController < ApplicationController
  
  before_action :logged_in_employee
  
  def index
    @faqs = Faq.search(params[:search]).paginate(page: params[:page])
  end
  
  def new
  end
  
  def create
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end
