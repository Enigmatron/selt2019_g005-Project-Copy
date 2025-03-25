# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'user.rb'

RSpec.describe User, type: :model do
  before do
    @user = User.create! handle: 'test', password: 'test123', password_confirmation: 'test123'
  end

  describe 'Creation Tests' do
    it 'base user' do
      @base = User.create! handle: 'base', password: 'test123', password_confirmation: 'test123'
      expect(@base.valid?).to eq true
    end
    it 'has non-null handle and password' do
      @test = User.create(password: 'test12')
      expect(@test.valid?).to eq false

      # @test = User.create(handle: 'test1')
      # expect(@test.valid?).to eq(false)

      @test = User.create(handle: 'test1', password: 'test123', password_confirmation: 'test123')
      expect(@test.valid?).to eq true
    end
    it 'has handle uniqueness' do
      @test = User.create(handle: 'test', password: 'test123', password_confirmation: 'test123')
      expect(@test.valid?).to eq false
      @test = User.create(handle: 'test1', password: 'test123', password_confirmation: 'test123')
      expect(@test.valid?).to eq true
    end

    it 'has non-empty handle and password' do
      @test = User.create(handle: ' ', password_digest: ' ')
      expect(@test.valid?).to eq false
      @test = User.create(handle: ' ', password_digest: 'password')
      expect(@test.valid?).to eq false
      @test = User.create(handle: 'user12', password_digest: ' ')
      expect(@test.valid?).to eq false
    end

    it 'makes a session token' do
      @test = User.create(@user.create_user!(handle: 'test1', password_digest: 'test'))
      expect(@test.has_attribute?(:session_token)).to eq true
    end
    it 'does omniauth' do
      auth = {}
      auth['info'] = {}
      auth['info']['email'] = 'iykysia@gmail.com'
      auth['uid'] = 'password'
      auth['provider'] = 'someone'
      @test = User.create_with_omniauth(auth)
      expect(@test).to be_a(User)
    end
    it 'has comments and topics with comments' do
      expect(@user.comments.empty?).to eq true
      @topic = Topic.create(subject: 'Dogs', header: 'dogs dogs dogs')
      expect(@topic.valid?).to eq false
      @topic.user = @user
      expect(@topic.valid?).to eq true

      @comment1 = Comment.create(comment: 'DOGS ARE GREAT')
      expect(@comment1.valid?).to eq false
      @comment1.user = @user
      @comment1.topic = @topic
      expect(@comment1.valid?).to eq true

      @comment2 = Comment.create(comment: 'DOGS RULE THE WORLD')
      expect(@comment2.valid?).to eq false
      @comment2.user = @user
      @comment2.topic = @topic
      expect(@comment2.valid?).to eq true

      @topic.comments << @comment1
      @topic.comments << @comment1

      # @user.topics << @topic
      @user.comments << @comment1
      @user.comments << @comment2

      expect(@user.valid?).to eq true
      expect(@user.comments.empty?).to eq false
    end
    it 'has topics' do
    end
  end
end
