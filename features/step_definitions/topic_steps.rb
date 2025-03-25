# frozen_string_literal: true

Given /the following topics have been added:/ do |topic_table|
  @user = User.create! handle: 'test', password: 'test123', password_confirmation: 'test123'
  topic_table.hashes.each do |topic|
    # @topic.user = @user
    @topic = Topic.create(topic)
    @topic.user = @user
    @topic.save!
  end
end

When /^I navigate to the topic creation page and create the new topic, "(.*?)"$/ do |arg1|
  visit new_topic_path
  fill_in 'topic_header', with: arg1
  select 'Dogs'
  find('input[name="commit"]').click
end

Then /^I expect to have my topic, "(.*?)" posted$/ do |arg1|
  # visit topics_path
  expect(page).to have_content(arg1)
end

Then /^I expect to have my comment, "(.*?)" posted on the topic "(.*?)"$/ do |comment, topic|
  expect(page).to have_content?(comment)
  expect(page).to have_content?(topic)
end

When /^I navigate to the topic, "(.*?)" and I comment "(.*?)"$/ do |topic, comment|
  visit topics_path
  click_on topic
  click_on 'Add Comment'
  expect(page).to have_xpath('//input')
  fill_in 'Comment', with: comment
  click_button 'commentCreate'
end

Given(/^That I'm at the topic page$/) do
  visit topics_path
end
