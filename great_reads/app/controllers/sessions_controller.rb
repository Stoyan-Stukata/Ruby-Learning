class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:login][:username])

    if @user && authenticate
      session[:user_id] = @user.id

      redirect_to root_path
    else
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil

    redirect_to root_path
  end

  private
    def authenticate
      BCrypt::Password.new(@user.password) == params[:login][:password]
    end
end
