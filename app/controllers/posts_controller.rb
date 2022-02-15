class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    # 新着順に表示
    @newcomings = Post.all.order(created_at: :desc) 
    # いいね数ランキング
    @likes_rankings = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    # フォローしている順
    @follows = Post.where(user_id: [*current_user.following_ids]).order(created_at: :desc)
   
    # @follows = Post.find(current_user.followed.group(:followed_id).order('count(post_id) desc').pluck(:followed_id))

  end

  # GET /posts/1 or /posts/1.json
  def show

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

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
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
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def dashboard
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:comment, :receiver_id)
    end
end
