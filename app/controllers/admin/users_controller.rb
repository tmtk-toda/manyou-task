class Admin::UsersController < ApplicationController
  before_action :admin_user, only: [:new, :index, :show, :edit, :update, :destroy]
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.includes(:tasks)
    @users = User.all.order("created_at DESC")
  end
  def show
    @tasks = @user.tasks
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    else
      render :new
    end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "ユーザーを削除できませんでした"
    end
  end
  private
  def admin_user
    if not current_user.admin
      flash[:notice] = ('権限はありません')
      redirect_to(root_path)
    end
  end
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
  def set_admin
    @user = User.find(params[:id])
  end
end