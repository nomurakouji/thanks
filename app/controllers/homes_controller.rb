class HomesController < ApplicationController
  def new_guest
    user = User.find_or_create_by(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.department_id = 6
    end
  # 上記のuserをログインさせることができる(deviseのメソッド)
  sign_in user
  redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end

  def new_guestadmin
    guestadmin = User.find_or_create_by(email: 'guestadmin@guestadmin.com') do |guestadmin|
      guestadmin.password = SecureRandom.urlsafe_base64
      guestadmin.admin = true
      guestadmin.department_id = 6
    end
  # 上記のguestadminをログインさせることができる(deviseのメソッド)
  sign_in guestadmin
  redirect_to root_path, notice: 'ゲスト管理者ユーザーとしてログインしました'
  end
end
