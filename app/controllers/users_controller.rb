class UsersController < ApplicationController

  def new
    @user = User.new
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

  private

  def do_whitelisting
    params.require(:user).permit(:user_name, :email,:password)
  end
end