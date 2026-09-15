class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_new_book, only: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  def show
    @books = @user.books
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :introduction, :profile_image, :email_address, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_new_book
    @book = Book.new
  end

  def ensure_correct_user
    unless @user == Current.user
      redirect_to user_path(Current.user)
    end
  end
end
