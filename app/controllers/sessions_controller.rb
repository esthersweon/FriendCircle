class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if @user
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password."]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
