class ReportsController < ApplicationController
  
  # 管理者の操作をふやす場合では、これはこのままで良い
  before_action :logged_in_employee, only: [:create, :destroy]
  
  # admin=1がonother_employee = report.employeeであるreportを削除できるようにする場合は、こちらのbefore_actionは消す必要がある。
  before_action :correct_employee,   only: :destroy

  def create
    @report = current_employee.reports.build(report_params)
    if @report.save
      flash[:success] = "日報を作成しました。"
      redirect_to root_url
    else
      # ホームから日報投稿→保存失敗でホームにリダイレクトする際にオブジェクトを明示しないとページネーションが正常に作動しない。
      # 現時点ではホーム画面しか無いのでこれでシンプルだが、投稿画面を複数設けると面倒な場合わけが必要。
      @timeline_items = current_employee.timeline.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @report.destroy
    flash[:success] = "日報を削除しました。"
    redirect_to request.referrer || root_url
  end
  
  private

    def report_params
      params.require(:report).permit(:content)
    end
    
    def correct_employee
      @report = current_employee.reports.find_by(id: params[:id])
      redirect_to root_url if @report.nil?
    end
end
