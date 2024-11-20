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
    redirect_to root_path
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end
  
  def show
    @users = User.find(params[:id])
  end
  
  def edit
    @user =User.find(params[:id])
  end
  
  def update
    c = User.update(my_company: params[:user][:my_company],
                 my_name: params[:user][:my_name],
                 pass: params[:user][:pass])
    c.save
    redirect_to root_path
  end
end
