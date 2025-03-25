# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe TopicsController do
  before do
    @user = User.new
    @user = User.create!(@user.create_user!(handle: 'test123', password: 'test123', password_confirmation: 'test123'))
    @user2 = User.new
    @user2 = User.create!(@user2.create_user!(handle: '2test123', password: 'test123', password_confirmation: 'test123'))
    @admin = User.new
    @admin = User.create!(@admin.create_user!(handle: 'admin', password: 'test123', password_confirmation: 'test123', Admin: true))
    @t = Topic.create! user: @user, header: 'test'
  end

  after do
    # Do nothing
  end
  describe 'TopicsController renders templates.' do
    it 'renders the edit template' do
      get :edit, params: { id: @t.id }
      expect(response).to render_template('edit')
    end

    it 'renders the index template' do
      controller.instance_variable_set(:@current_user, nil)

      get :index
      expect(response).to render_template('index')
      expect(@controller.instance_variable_get(:@topics)).to eq(Topic.all)

      @controller.instance_variable_set(:@topics, nil)
      get :index, params: { header: 'test' }
      expect(controller.instance_variable_get(:@topics)).to_not be_nil
      expect(response).to render_template('index')

      @controller.instance_variable_set(:@current_user, @user)
      get :index
      expect(response).to render_template('index')
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
    it 'renders the show template' do
      get :show, params: { id: @t.id }
      expect(response).to render_template('show')
    end
    it 'renders the delete template' do
      expect(delete: "/topics/#{@t.id}", controller: 'topics', id: @t.id.to_s).to route_to(controller: 'topics', action: 'destroy', id: @t.id.to_s)
    end
    it 'upvotes' do
      controller.instance_variable_set(:@current_user, nil)
      get :upvote, params: { id: @t.id }
      expect(response).to redirect_to topics_path
      # @test =

      controller.instance_variable_set(:@current_user, @user2)

      # expect(@t).to receive(:liked_by)
      # allow(@t).to should_receive(:liked_by)
      get :upvote, params: { id: @t.id }
      expect(response).to redirect_to topics_path
      # @t.act
      # expect().to have_received(:liked_by)

      # expect(@t).to receive(:unliked_by)
      # allow(@t).to should_receive(:unliked_by)
      get :upvote, params: { id: @t.id }
      expect(response).to redirect_to topics_path
      # expect(@t).to have_received(:unliked_by)
    end
  end

  describe 'TopicsController post route validation' do
    it 'Updates' do
      @test = Topic.create! header: 'cats', user: @user
      patch :update, params: { topic: { header: 'cats2' }, id: @test.id }
      @test = Topic.find_by(header: 'cats2')
      expect(@test).to_not be_nil
      expect(@test).to be_a(Topic)
    end
    it 'Creates' do
      controller.instance_variable_set(:@current_user, @user)
      post :create, params: { topic: { header: 'cats' } }
      @test = Topic.find_by(header: 'cats')
      expect(@test).to be_a(Topic)
    end
    it 'Fails Create' do
      controller.instance_variable_set('@current_user', nil)

      post :create, params: { topic: { header: 'cat' } }
      expect(response).to render_template('new')

      # controller.instance_variable_set(:@current_user, @user)

      post :create, params: { topic: { header: '' } }
      expect(response).to render_template('new')
      # @test = Topic.find_by(header: 'cats')
      # expect(response).to route_to('new')
    end
    it 'Destroys' do
      delete :destroy, params: { id: @t.id }

      @result = Topic.find_by(header: 'test')
      expect(@result).to_not be_a(Topic)
    end
  end
end
