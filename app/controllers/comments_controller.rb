class CommentsController < ApplicationController

  before_action :set_current_user # calls the current user method in application controller
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def new
    @topic = Topic.find(params[:topic_id])
  end

  def create
    if @current_user.nil?
      flash[:notice] = "Must sign in to comment"
      render 'new'
    else
      @topic = Topic.find(params[:topic_id])
      @comment = @topic.comments.build(comment_params)
      @current_user.comments << @comment
      if !@comment.nil?
        # flash[:notice] = "Comment successfully added"
        redirect_to topic_path(@topic)
      else
        flash[:notice] = "Must write something"
        render 'new'
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  def edit
    # e
  end

  def update
    # e
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render 'new'
  end
end
