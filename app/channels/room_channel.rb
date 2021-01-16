class RoomChannel < ApplicationCable::Channel
  # サーバー側からフロント側を監視できているかを確認できたときに動くメソッド
   def subscribed
       stream_from "room_channel"
   end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
