class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.order(created_at: :desc)   
  end
  
  def show
    @books = @user.books.order(created_at: :desc)
    @book  = Book.new
  end

  def edit; end
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_user; @user = User.find(params[:id]); end

  def is_matching_login_user
    return if @user == current_user
    redirect_to user_path(current_user)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
