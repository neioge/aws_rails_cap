class FaqsController < ApplicationController
  
  before_action :logged_in_employee
  
  def index
    @faqs = Faq.search(params[:search]).paginate(page: params[:page])
    if @faqs.length == 0
      flash.now[:danger] = "一致する結果はありませんでした。"
      @faqs = Faq.paginate(page: params[:page])
      render 'index'
    end
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
