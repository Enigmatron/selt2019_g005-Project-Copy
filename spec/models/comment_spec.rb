# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'topic.rb'

RSpec.describe Topic do
  before do
    @user = User.create! handle: 'test', password: 'test123', password_confirmation: 'test123'
    @topic = Topic.create header: 'DOGS ARE BEST', subject: 'dogs'
    @topic.user = @user
  end

  describe 'Creation Tests' do
    it 'nullable checks' do
      @comment = Comment.create
      expect(@comment.valid?).to eq(false)
      @comment.comment = 'DOGS ARE BEST'
      expect(@comment.valid?).to eq(false)
      @comment.user = @user
      expect(@comment.valid?).to eq(false)
      @comment.topic = @topic
      expect(@comment.valid?).to eq(true)
    end
    it 'empty comment' do
      @comment = Comment.create comment: ''
      @comment.user = @user
      @comment.topic = @topic
      expect(@comment.valid?).to eq(false)
    end
    it 'Destroys' do
      @comment = Comment.create comment: ''
      @comment.user = @user
      @comment.topic = @topic
      expect { @comment.destroy! }.to_not raise_error
    end
    it 'expecting many comments' do
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
  end
end
