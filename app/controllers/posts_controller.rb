class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy draft_show ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    # 新着順に表示
    @newcomings = Post.order(created_at: :desc).where(is_draft: false)
    # いいね数ランキング
    @likes_rankings = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    # フォローしている順
    @follows = Post.where(user_id: [*current_user.following_ids]).where(is_draft: false).order(created_at: :desc)

  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  def draft
    @posts = Post.order(created_at: :desc).where(is_draft: true)
  end

  def draft_show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post_name = current_user.name
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 公開時だけバリデーション(下書きはバリデーションなし)
    # 感謝を投稿ボタンを押した場合
    if params[:commit] == "感謝を投稿"
      if @post.save(context: :publicize)
        redirect_to post_url(@post), notice: "投稿しました" 
      else
        render :new
      end
    else params[:commit] == "下書きを保存"
    # 下書きボタンを押した場合
        @post.update(is_draft: true)
        redirect_to post_url(@post), notice: "下書きを保存しました"
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "投稿を編集しました" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  def dashboard
  end
  
  def instructions
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:comment, :receiver_id, :is_draft)
    end
end
