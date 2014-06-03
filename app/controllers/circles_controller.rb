class CirclesController < ApplicationController
  before_action :require_signed_in
  def index
    @user = current_user
    render :index
  end

  def new
    @circle = Circle.new
    @users = User.all
    render :new
  end

  def create
    @circle = current_user.circles.new(circle_params)

    if @circle.save
      redirect_to circle_url(@circle)
    else
      @users = User.all
      flash.now[:errors] = @circle.errors.full_messages
      render :new
    end

    def show
      @circle = Circle.find(params[:id])
      render :show
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:title, :user_id, :member_ids => [])
  end
end
