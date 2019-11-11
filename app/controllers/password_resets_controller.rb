class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "メールをご確認ください"
      redirect_to root_url
    else
      flash[:danger] = "メールアドレスが間違っています"
      render  "new"
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?                  #パスワードが空だった場合への対処
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)          
      log_in @user
      flash[:success] = "パスワードはリセットされました"
      redirect_to @user
    else
      render 'edit'                                     
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "時間切れです。もう一度やり直してください"
        redirect_to new_password_reset_url
      end
    end
end
