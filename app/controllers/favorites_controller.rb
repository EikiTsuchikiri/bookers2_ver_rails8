class FavoritesController < ApplicationController
  before_action :set_book, only: [:create, :destroy]

  def create
    @favorite = Current.user.favorites.create(book: @book)
    render "replace_btn"
  end

  def destroy
    @favorite = Current.user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    render "replace_btn"
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
