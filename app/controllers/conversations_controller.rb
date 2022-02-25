class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = Conversation.all
  end

  def create
    # 任意のsender_idとrecipient_idの組み合わせの会話が存在するか
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      # 存在した場合、最初の組み合わせ（組み合わせ自体は何番目でも同じ）をインスタンス変数に代入
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
