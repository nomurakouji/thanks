class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications #.page(params[:page]).per(10)
    # checkedカラムがfalseのレコードを全て呼び出す
    @notifications.where(checked: false).each do |notification|
    # update_attributeメソッド: レコードの一つのカラムを変更できる
      notification.update_attributes(checked: true)

    end
  end
end
