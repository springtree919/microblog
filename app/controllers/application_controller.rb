class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to root_url
      end
  end
  
  def not_looged_in_user
    if logged_in?
      redirect_to home_url
    end
  end
end
