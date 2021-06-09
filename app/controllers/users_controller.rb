class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5 ).order(created_at: :desc )
  end

  def new
    @user = User.new
  end

  def show 
  end

  def create
    @user = User.new(do_whitelisting)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User signed up sucessfully"
      redirect_to articles_path
    else
      flash[:notice] = "User sign up failed"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(do_whitelisting)
      flash[:notice] = "Sucessfully updated the user"
      redirect_to users_path  
    else  
      flash[:notice] = "Failed to update the user"
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Account deleted Sucessfully"
      redirect_to root_path
    end
  end

  private

  def do_whitelisting
    params.require(:user).permit(:user_name, :email,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can update only your own record"
      redirect_to @user
    end
  end
end