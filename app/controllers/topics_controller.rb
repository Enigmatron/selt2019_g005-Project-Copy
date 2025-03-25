# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :set_current_user # calls the current user method in application controller

  helper_method :find_user
  # we are using rails >5.0 and before_filter does not work for rails >5.0
  def topic_params
    params.require(:topic).permit(:header, :subject)
  end
  def find_user(user_id)
    User.find_by_user_id(user_id)
  end

  def show
    id = params[:id]
    @topic = Topic.find(id)
    @comments = Comment.where(topic_id: @topic.topic_id)
  end

  def index
    if @current_user.nil?
      if params[:header]
        @topics = Topic.where("#{params[:type]} LIKE ?", "%#{params[:header]}%")
      else
        @topics = Topic.all
      end
    else
      @current_user.ip_address = request_ip
      @current_user.geocode
      if params[:header]
        @topics = Topic.where("#{params[:type]} LIKE ?", "%#{params[:header]}%")
        @topics.select { |t| @current_user.distance(t)< 10}
      else
        @topics = Topic.all
      end
      @topics.select do |t|
        Geocoder::Calculations.distance_between([@current_user.latitude, @current_user.longitude],
                                                [t.latitude, t.longitude]) < 10
        end

    end

  end

  def new
    @comment = Comment.new(topic_id: params[:topic_id])
  end

  def upvote
    id = params[:id]
    @topic = Topic.find(id)
    unless @current_user.nil?
      if @current_user.voted_for? @topic
        @topic.unliked_by @current_user
      else
        @topic.liked_by @current_user
      end

    end
    redirect_to topics_path
  end

  def create

    if @current_user.nil?
      flash[:notice] = 'Must log in to post'
      render 'new'
    else
      @topic = Topic.new(topic_params)
      @topic.ip_address = request_ip
      @topic.geocode
      @topic.user = @current_user
      @topic.save!
      if @topic.save
        redirect_to topic_path(@topic)
      else
        render 'new'
      end
    end

  end

  def edit
    @topic = Topic.find params[:id]
  end

  def update
    @topic = Topic.find params[:id]
    if @topic.update(topic_params)
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if !@current_user.nil? && @topic.user_id == @current_user.id
      @comments = Comment.where("topic_id = #{@topic.topic_id}")
      @comments.each { |comment| comment.destroy }
      @topic.destroy
      redirect_to topics_path
    else
      flash[:notice] = 'This is not your topic'
      redirect_to topics_path
    end
  end

  def delete_topic
    # TODO Check Box options
    # puts params[:id]

    redirect_to topics_path
    # @topic = Topic.find(params[:id])
    # @topic.destroy
    #
    # redirect_to topics_path
      # where(rating: @selected_ratings.keys).order(ordering)
  end
end
