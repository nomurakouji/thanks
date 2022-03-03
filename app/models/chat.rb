class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # 投稿時間の表示
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
