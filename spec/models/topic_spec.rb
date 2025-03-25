# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'topic.rb'

RSpec.describe Topic do
  before do
    @user = User.create! handle: 'test123', password: 'test123', password_confirmation: 'test123'
  end

  describe 'Creation Tests' do
    it 'nullable checked for' do
      @topic = Topic.create header: 'DOGS ARE BEST'
      expect(@topic.valid?).to eq(false)
      @topic.subject = 'dogs'
      expect(@topic.valid?).to eq(false)
      @topic.user = @user
      expect(@topic.valid?).to eq(true)

      @topic2 = Topic.create header: 'DOGS ARE BEST'
      expect(@topic2.valid?).to eq(false)
      # @topic2.subject = "dogs"
      # expect(@topic.valid?).to eq(false)
      @topic2.user = @user
      expect(@topic.valid?).to eq(true)
    end
    it 'expecting many comments' do
      @topic = Topic.create header: 'DOGS ARE BEST', subject: 'dogs'
      @topic.user = @user

      @comment1 = Comment.create comment: 'dogs?'
      @comment2 = Comment.create comment: 'WRRY DOGGO DOGA DOG'
      @comment3 = Comment.create comment: 'creativity'
      @comment1.user = @user
      @comment2.user = @user
      @comment3.user = @user

      @topic.comments << @comment1
      @topic.comments << @comment2
      @topic.comments << @comment3
      expect(@topic.valid?).to eq(true)
    end
    it 'search test' do
      @topic = Topic.create! header: 'dogs', user: @user, subject: 'dogs'
      expect(Topic.search('dog')).to contain_exactly(@topic)
    end
  end
end
