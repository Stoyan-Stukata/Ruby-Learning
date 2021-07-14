class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && :authenticate
      session[:user_id] = @user.id

      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
  end

  private
    def authenticate
      BCrypt::Password.new(@user.password) == params[:password]
    end
end
