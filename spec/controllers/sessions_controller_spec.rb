# frozen_string_literal: true

require 'rspec'

RSpec.describe SessionsController do
  before do
    @user = User.new
    @user = User.create!(@user.create_user!(handle: 'test123', password: 'test123', password_confirmation: 'test123'))
    @admin = User.new
    @admin = User.create!(@admin.create_user!(handle: 'admin', password: 'test123', password_confirmation: 'test123', Admin: true))
    @authUser = User.new
    @authUser = User.create!(@authUser.create_user!(handle: 'auther', password: 'test123', password_confirmation: 'test123', provider: 'someone', uid:'password'))
  end
  describe 'SessionsController post route validation' do
    it 'Fails Create' do
      post :create, params: { user: { handle: 'test', password: 'test123' } }
      expect(controller.instance_variable_get(:@current_user)).to be_nil
      expect(session[:session_token]).to_not eq(@user.session_token)

      post :create, params: { user: { handle: 'test123', password: 'test124' } }
      expect(controller.instance_variable_get(:@current_user)).to be_nil

      expect(session[:session_token]).to_not eq(@user.session_token)
    end
    it 'Creates and destroys' do
      post :create, params: { user: { handle: 'test123', password: 'test123' } }
      expect(session[:session_token]).to eq(@user.session_token)
      expect(response).to redirect_to(topics_path)


      delete :destroy


      post :create, params: { user: { handle: 'admin', password: 'test123' } }
      expect(session[:session_token]).to eq(@admin.session_token)
      expect(response).to redirect_to(users_admin_path)

      delete :destroy

      auth = {}
      auth['info'] = {}
      auth['info']['email'] = 'iykysia@gmail.com'
      auth['uid'] = 'password'
      auth[:handle] = 'handle'
      auth[:password] = 'password'
      auth['provider'] = 'someone'
      request.env['omniauth.auth'] = auth

      post :create
      expect(session[:session_token]).to eq(@authUser.session_token)
      expect(response).to redirect_to(topics_path)


    end
  end
end
