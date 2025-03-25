# frozen_string_literal: true

###
### GIVEN
###

Given /^I'm at the sign up page$/ do
  visit new_user_path
end

Given /the following users have been added:/ do |user_table|
  # visit new_movie_path
  user_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /^That I'm at the login page$/ do
  visit login_path
end

###
### WHEN
###

When /^I sign up with "(.*?)" as a handle and "(.*?)" as a password and press submit$/ do |handle, password|
  visit new_user_path
  fill_in 'Handle', with: handle
  fill_in 'Password', with: password
  fill_in 'Confirm Password', with: password
  click_button 'Create Your Account'
end

When /^I have logged in with "(.*?)" handle and "(.*?)" password$/ do |handle, password|
  # visit
  fill_in 'loginUser', with: handle
  fill_in 'loginPassword', with: password
  click_button 'Sign in'
end

###
### THEN
###

Then /^I expect to have successfully signed up as "(.*?)"$/ do |handle|
  @user = User.find_by(handle: handle)
  expect(@user).is_a?(User)
end

Then /^I am on main page$/ do
  expect(page).to have_current_path(topics_path, ignore_query: true)
end

Then /^I expect to have successfully login as "(.*?)"$/ do |_handle|
  expect(page).to have_current_path(topics_path, ignore_query: true)
end
Then /^I expect to have failed to login as "(.*?)"$/ do |_handle|
  expect(page).not_to have_current_path(topics_path, ignore_query: true)
end
