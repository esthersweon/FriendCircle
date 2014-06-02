class PostsController < ApplicationController
  before_action :require_signed_in
  
  def index
    @user = current_user
    @posts = Post.where(user_id: current_user.id)
    render :index
  end

  def new
    @post = Post.new
    @circles = Circle.where(user_id: current_user.id)
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_url
    else
      flash.now[:errors]= @post.errors.full_messages
    end
  end

  def post_params
    params.require(:post).permit(:body, :circle_ids => [])
  end
end
