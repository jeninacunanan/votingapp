class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully deleted user."
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit!
    end

    def set_user
      @user = User.find(params[:id])
    end
end
