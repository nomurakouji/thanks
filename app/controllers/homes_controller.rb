class HomesController < ApplicationController
  def new_guest
    user = User.find_or_create_by(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  # 上記のuserをログインさせることができる(deviseのメソッド)
  sign_in user
  redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました'
  end
end
