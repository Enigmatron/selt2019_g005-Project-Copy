# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
# require 'models/topic'

describe CommentsController do
  before do
    @user = User.create! handle: 'test123', password: 'test123', password_confirmation: 'test123'
    @topic = Topic.create! header: 'Cats are pretty good', user: @user
    @comment = Comment.create! comment: 'test', user: @user, topic: @topic
  end
  describe 'UsersController renders templates.' do
    it 'renders the edit template' do
      get :edit, params: { topic_id: @topic.id, id: @comment.id }
      expect(response).to render_template('edit')
    end

    it 'renders the index template' do
      get :index, params: { topic_id: @topic.id }
      expect(response).to render_template('index')
    end

    it 'renders the new template' do
      get :new, params: { topic_id: @topic.id }
      expect(response).to render_template('new')
    end
    it 'renders the show template' do
      get :show, params: { topic_id: @topic.id, id: @comment.id }
      expect(response).to render_template('show')
    end
  end

  describe 'CommentsController post route validation' do
    it 'renders the delete template' do
      expect(delete: "topics/#{@topic.id}/comments/#{@comment.id}", controller: 'comments', id: @comment.id.to_s)
        .to route_to(controller: 'comments', action: 'destroy', topic_id: @topic.id.to_s, id: @comment.id.to_s)
    end
    it 'Creates' do
      controller.instance_variable_set(:@current_user, @user)

      post :create, params: { comment: { comment: 'cats' }, topic_id: @topic.id }
      @test = Comment.find_by(comment: 'cats')
      expect(@test).to be_a(Comment)
      expect(response).to redirect_to(topic_path(@topic.id))
    end
    it 'Fails Create' do
      post :create, params: { comment: { comment: 'cats' }, topic_id: @topic.id }
      expect(response).to render_template('new')

      controller.instance_variable_set(:@current_user, @user)
      expect { post :create, params: { topic_id: @topic.id } }.to raise_error(ActionController::ParameterMissing)

      post :create, params: { comment: { comment: '' }, topic_id: @topic.id }
      expect(response).to render_template('new')
    end
    it 'Updates' do
      @test = Comment.create! comment: 'cats', user: @user, topic: @topic
      patch :update, params: { comment: { comment: 'cats2' }, topic_id: @topic.id, id: @test.id }
      @test = Comment.find_by(comment: 'cats2')
      expect(@test).to_not be_nil
      expect(@test).to be_a(Comment)
    end
    it 'Destroys' do
      controller.instance_variable_set(:@current_user, @user)

      # post :create, params: { comment: { comment: 'cats'}, topic_id:@topic.id}
      # @test = Comment.find_by(comment: 'cats')
      @test = Comment.create! comment: 'cats', user: @user, topic: @topic

      # expect{delete :destroy, params:{id: @test.id}}.to routes
      delete :destroy, params: { topic_id: @topic.id, id: @test.id }
      @result = Comment.find_by(comment: 'cats')
      expect(@result).to_not be_a(Comment)
    end
  end
end
