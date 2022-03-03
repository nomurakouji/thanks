class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(5)
    # いいねされており、かつ、checkedカラムがfalseのレコードを全て呼び出す
    @notifications.where(action: "Like",checked: false).each do |notification|
      # update_attributeメソッド: レコードの一つのカラムを変更できる
      notification.update_attributes(checked: true)
    end
    # フォローされており、かつ、checkedカラムがfalseのレコードを全て呼び出す
    @notifications.where(action: "follow",checked: false).each do |notification|
      # update_attributeメソッド: レコードの一つのカラムを変更できる
      notification.update_attributes(checked: true)
    end
    # # チャットされており、かつ、checkedカラムがfalseのレコードを全て呼び出す
    # @notifications.where(action: "chat",checked: false).each do |notification|
    #   # update_attributeメソッド: レコードの一つのカラムを変更できる
    #   notification.update_attributes(checked: true)
    # end
  end
end
