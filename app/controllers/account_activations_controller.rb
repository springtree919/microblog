class AccountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "認証成功"
      redirect_to user
    else
      flash[:danger] = "認証失敗。再度やり直してください"
      redirect_to signup_path
    end
  end
end
