class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    User.find_by(id: session[:user_id])  
  end

  def logged_in?
    current_user.present?
  end

  # private
  #   def require_login
  #     unless current_user
  #       redirect_to '/login'
  #     end  
  #   end
end 
