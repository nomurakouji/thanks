class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  # with_options => バリデーション内容が共通の時
  # on: :publicize => context: :publicizeの時だけバリデーション
  with_options presence: true, on: :publicize do
  validates :comment
  validates :receiver_id
  end
  validates :comment, length: {maximum: 50}, on: :publicize

  def create_notification_by(current_user)
    # すでに「いいね」されているか検索（実際はデータベースから一致する条件のものを全て検索している）
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない（一致するものがない）場合のみ、通知レコードを作成
    if temp.blank?
    # current_user.active_notifications = visiter_idにcurrent_user.idを代入
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "Like"
    )
    # 自分の投稿に対するいいねの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end

    # norificationの値が有効であればnotification変数の値をsave
    notification.save if notification.valid?
    end
  end
end
