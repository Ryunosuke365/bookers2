class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_or_initialize_by(book_id: book.id)
    favorite.save
    redirect_back fallback_location: book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite&.destroy
    redirect_back fallback_location: book_path(book)
  end
end

