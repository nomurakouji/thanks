class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリデーション
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :image, presence: true
  # 新規レコード作成時（userをnewする場合のみ）のみ、バリデーション
  validates :password, presence: true, on: :create   
  # アソシエーションのバリデーション
  validates :department_id, :presence => true
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  belongs_to :department, optional: true
  # いいねを押したかを判別するメソッド
  def liked_by?(post_id)
    # whereメソッドは基本用法=>モデル.where("条件")
    likes.where(post_id: post_id).exists?
  end
  # 画像投稿
  mount_uploader :image, ImageUploader
  # 紐付ける名前とクラス名が異なるため、明示的にクラス名とIDを指定して紐付け
  # active_notificataions => 自分からの通知 , passive_notifications => 相手からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  #active_relationships => フォローする人 , passive_relationships => フォローされた人
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id',  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  # フォロー機能
  # ユーザーをフォロー(followed_idにother_userを追加)
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end
  # ユーザーのフォロー解除(followed_idを削除)
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  # 現在のユーザーがフォローしているか確認(その場合はtrueを返す)
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
end
