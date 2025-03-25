# frozen_string_literal: true

require 'users_controller.rb'
# require 'rspec.rb'
require 'spec_helper'
require 'rails_helper'

# run "rails db:migrate RAILS_ENV=test"
describe UsersController do
  before do
    @user = User.create! handle: 'test123', password: 'test123', password_confirmation: 'test123'
  end

  describe 'UsersController renders templates.' do
    it 'renders the edit template' do
      get :edit, params: { id: @user.id }
      expect(response).to render_template('edit')
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
    it 'renders the show template' do
      get :show, params: { id: @user.id }
      expect(response).to render_template('show')
    end
    it 'renders the delete template' do
      expect(delete: "/users/#{@user.id}", controller: 'users', id: @user.id.to_s).to route_to(controller: 'users', action: 'destroy', id: @user.id.to_s)
    end
  end

  describe 'UserController post route validation' do
    it 'Correct Delete user testing' do
      User.create! handle: 'idries', password: 'kysia1', password_confirmation: 'kysia1'

      @test = User.find_by handle: 'idries'
      expect(@test).to be_a User

      delete :destroy, params: { id: @test.id }

      @result = User.find_by(handle: 'idries')
      expect(@result).to_not be_a(User)
    end
    # .to change(User, :count).by(-1)
    it 'Updates' do
      User.create! handle: 'idries', password: 'kysia1', password_confirmation: 'kysia1'
      @test = User.find_by(handle: 'idries')
      patch :update, params: { user: { handle: 'cats2', password: 'test123', password_confirmation: 'test123' }, id: @test.id }
      @test = User.find_by(handle: 'cats2')
      expect(@test).to be_a(User)
    end
    it 'Correct Create user testing' do
      post :create, params: { user: { handle: 'cats', password: 'test123', password_confirmation: 'test123' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to be_a(User)

      post :create, params: { user: { handle: 'catscatscatscatscatscatscatscatscatscats', password: 'test123', password_confirmation: 'test123' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to be_a(User)
    end
    it 'Incorrect Create user testing' do
      post :create, params: { user: { handle: 'cats', password: 'test1', password_confirmation: 'test1' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to_not be_a(User)

      post :create, params: { user: { handle: 'catscatscatscatscatscatscatscatscatscats1', password: 'test123', password_confirmation: 'test123' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to_not be_a(User)

      post :create, params: { user: { handle: 'cats', password: 'test1223', password_confirmation: 'test123' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to_not be_a(User)

      post :create, params: { user: { handle: 'cats', password: 'test123', password_confirmation: 'test1223' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to_not be_a(User)

      post :create, params: { user: { handle: '', password: 'test123', password_confirmation: 'test123' } }
      @test = User.find_by(handle: 'cats')
      expect(@test).to_not be_a(User)
    end
  end
end
