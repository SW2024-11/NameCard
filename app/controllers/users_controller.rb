class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    c = User.new(my_company: params[:user][:my_company], 
                 my_name: params[:user][:my_name], 
                 pass: params[:user][:pass])
    c.save
    redirect_to cards_path
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user =User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(my_company: params[:user][:my_company],
                 my_name: params[:user][:my_name],
                 pass: params[:user][:pass])
    redirect_to users_path
    else
      render 'edit'
    end
  end
end
