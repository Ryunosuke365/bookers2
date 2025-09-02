class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book,          only: [:show, :edit, :update, :destroy]
  before_action :correct_user!,     only: [:edit, :update, :destroy]

  def index
    @new_book = Book.new
    @books = Book.includes(:user).order(created_at: :desc)
  end

  def show
    @new_book = Book.new
  end

  def edit; end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      @books = Book.includes(:user).order(created_at: :desc)
      @new_book = @book
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
  def set_book
    @book = Book.includes(:user).find(params[:id])
  end

  def correct_user!
    redirect_to books_path unless current_user && @book.user_id == current_user.id
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
