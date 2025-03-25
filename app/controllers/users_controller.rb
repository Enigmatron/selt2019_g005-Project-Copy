class UsersController < ApplicationController

  before_action :set_current_user, :only=> ['show', 'edit', 'update', 'destroy', 'admin', 'index']

  def user_params
    params.require(:user).permit(:handle, :password, :password_confirmation)
  end

  def admin

  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user = User.create!(@user.create_user!(user_params))
      flash[:notice] = "Welcome #{@user.handle}. Your account has been created."
      redirect_to login_path
    else
      flash[:notice] = 'Invalid input. Try again.'
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    flash[:notice] = "#{@user.handle} was successfully updated."
  end

  def destroy
    @user = User.find(params[:id])
    @comments = Comment.where("user_id = #{@user.user_id}")
    @comments.each { |comment| comment.destroy }
    @topics = Topic.where("user_id = #{@user.user_id}")
    @topics.each do |topic|
      @comments = Comment.where("topic_id = #{topic.topic_id}")
      @comments.each { |comment| comment.destroy }
      topic.destroy
    end
    @user.destroy
    redirect_to users_path
  end
end
