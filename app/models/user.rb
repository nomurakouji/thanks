class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end
  belongs_to :department, optional: true
  mount_uploader :image, ImageUploader
  # 紐付ける名前とクラス名が異なるため、明示的にクラス名とIDを指定して紐付け
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
end
