class HomesController < ApplicationController
  def new_guest
    user = User.find_or_create_by(email: 'guest@guest.com') do |user|
      # user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.password = 'password'
      user.department_id = 2
    end
    # 上記のuserをログインさせることができる(deviseのメソッド)
    sign_in user
    redirect_to root_path  #, notice: 'ゲストユーザーとしてログインしました'
  end
  
  def new_guestadmin
    guestadmin = User.find_or_create_by(email: 'guestadmin@guestadmin.com') do |guestadmin|
      # guestadmin.password = SecureRandom.urlsafe_base64
      guestadmin.name = '管理者'
      guestadmin.password = 'password'
      guestadmin.department_id = 1
      guestadmin.admin = true
    end
  # 上記のguestadminをログインさせることができる(deviseのメソッド)
  sign_in guestadmin
  redirect_to dashboard_path  #, notice: 'ゲスト管理者ユーザーとしてログインしました'
  end
end
