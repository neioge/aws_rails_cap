class RoomsController < ApplicationController
  def show
    # 投稿一覧表示に利用
    # @messages = Message.includes(:employee).order(:id)
    # 次の一行を変更。最新の１００件のみ取得する。
    @messages = Message.includes(:employee).order(:id).last(100)
    
    # メッセージ投稿に利用
    @message = current_employee.messages.build
  end
  
  def show_additionally
    # 追加のメッセージ50件を取得する
    last_id = params[:oldest_message_id].to_i - 1    
    @messages = Message.includes(:employee).order(:id).where(id: 1..last_id).last(50)
  end
    
end
