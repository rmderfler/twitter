class UsersController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      session[:user_id] = @user.id
      flash[:notice] = "User was added"
      redirect_to session_user_path(session, @user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      if @user.update(user_params)
        @user.update_attribute(:email, params[:user])
        flash[:notice] = "User updated."
        redirect_to session_user_path(session, @user)
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @current_user.id == @user.id
      if @user.destroy
        current_user.destroy
        session[:user_id] = nil
        flash[:notice] = "The user was deleted."
        redirect_to root_path
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end