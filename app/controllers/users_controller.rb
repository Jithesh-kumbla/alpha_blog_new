class UsersController < ApplicationController


  def index
    @users = User.paginate(page: params[:page], per_page: 5 )
  end

  def new
    @user = User.new
  end

  def show 
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(do_whitelisting)
    if @user.save
      flash[:notice] = "User signed up sucessfully"
      redirect_to articles_path
    else
      flash[:notice] = "User sign up failed"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(do_whitelisting)
      flash[:notice] = "Sucessfully updated the user"
      redirect_to users_path  
    else  
      flash[:notice] = "Failed to update the user"
      render 'edit'
    end
  end

  private

  def do_whitelisting
    params.require(:user).permit(:user_name, :email,:password)
  end
end