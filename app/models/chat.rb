class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  # 投稿時間の表示
  def message_time
    created_at.strftime("%Y-%m-%d(%a) %H:%M")
  end

  def chat_by(current_user)
    # すでに「いいね」されているか検索（実際はデータベースから一致する条件のものを全て検索している）
    temp = Notification.where(["visiter_id = ? and visited_id = ? and chat_id = ? and action = ? ", current_user.id, user_id, id, 'chat'])
    # いいねされていない（一致するものがない）場合のみ、通知レコードを作成
    if temp.blank?
    # current_user.active_notifications = visiter_idにcurrent_user.idを代入
    notification = current_user.active_notifications.new(
      chat_id: id,
      visited_id: user_id,
      action: "chat"
    )
    # norificationの値が有効であればnotification変数の値をsave
    notification.save if notification.valid?
    end
  end
end
