class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @q = Book.ransack(params[:q])
    if params[:q].present?
      @books = @q.result(distinct: true).includes(:user)
    else
      @books = Book.all.includes(:user)
    end
  end

  def create
    @book = Current.user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all.includes(:user)
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @new_book = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    unless @book.user == Current.user
      redirect_to books_path
    end
  end
end
