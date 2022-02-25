class Conversation < ApplicationRecord
  belongs_to :sender,foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy

  # [:sender_id, :recipient_id]が同じ組み合わせで保存されないようにするためのバリデーション
  validates_uniquness_of :sender_id, scope: :recipient_id

  # コントローラのbetweenメソッドを定義
  # ?は存在すればtrue,なければfalseを返す(会話を申し込んだパターンと申し込まれたパターンの両方を検索するメソッド)
  # 一つ目の(conversations.sender_id = ? AND conversations.recipient_id = ?)のsender_idとrecipient_idにはそのまま一つ目と二つ目のsender_id ,recipient_idという変数の組み合わせが入る
  # ORより後の記述の二つ目の(conversations.sender_id = ? AND conversations.recipient_id = ?)には、三つ目と四つ目のrecipient_id, sender_idという、先ほどと逆転した変数の組み合わせが入る
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

# ログインユーザーに関連している他のユーザーの情報を取得するメソッド
# ログインユーザーがチャットルームを作成したパターンと、ログインユーザーの相手がチャットルームを作成したパターンのどちらかで存在
  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end
end
