class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
