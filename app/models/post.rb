class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

  def create_notification_by(current_user)
    # すでに「いいね」されているか検索（実際はデータベースから一致する条件のものを全て検索している）
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない（一致するものがない）場合のみ、通知レコードを作成
    if temp.blank?
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "Like"
    )
    ##### 自分の投稿に対するいいねの場合は、通知済みとする
    # if notification.visiter_id == notification.visited_id
    #   notification.checked = true
    # end

    # norificationの値が有効であればnotification変数の値をsave
    notification.save if notification.valid?
    end
  end
end
