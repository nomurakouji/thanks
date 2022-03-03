class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    # user_roomsテーブルのuser_idが主のレコードのroom_idを配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # user_roomでルームを取得できなかった（主とゲストのチャットが存在しない）場合の処理
    room = nil
    if user_room.nil?
      room = Room.new
      room.save
      # 主とゲストのuser_roomをそれぞれ作成
      UserRoom.create(user_id: @user.id, room_id: room.id)
      UserRoom.create(user_id: current_user.id, room_id: room.id)
    else
      # user_roomに紐づくroomテーブルのレコードを変数roomに格納
      room = user_room.room
    end
    # roomに紐づくchatsテーブルのレコードを@chatsに格納（チャット履歴(@chats)の取得）
    @chats = room.chats
    # form_withでチャットを送信する際に必要な空のインスタンス（新規投稿用の空インスタンス(@chat)作成）
    @chat = Chat.new(room_id: room.id)
    # 既読と未読を判別するロジック
    if @chats.last
      @chats.where(user_id: current_user.id).update_all(read: true)
    end
  end

  def create
    # @chat = current_user.chats.new(chat_params)
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_path(@chat) } # HTMLで返す場合、showアクションを実行し詳細ページを表示
        format.js  # create.js.erbが呼び出される
      else
        format.html { render :show } 
        format.js { render :errors } 
      end
    end
    # @user = User.find(params[:id])
    # チャットが投稿されたときに通知レコードを作成する
    @chat.chat_by(current_user)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id, :user_id)#.merge(user_id: current_user.id)
  end
end
