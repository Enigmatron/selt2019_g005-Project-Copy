# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {:handle => 'Admin', :password => 'ADMINISTER', :password_confirmation => 'ADMINISTER', :session_token => "#{SecureRandom.base64}", :Admin => true},
  {:handle => 'Alan', :password => 'Datamanager', :password_confirmation => 'Datamanager', :session_token => "#{SecureRandom.base64}", :Admin => false},
  {:handle => 'Steve', :password => 'Swimming', :password_confirmation => 'Swimming', :session_token => "#{SecureRandom.base64}", :Admin => false},
  {:handle => 'Chichi', :password => 'Scrummaster', :password_confirmation => 'Scrummaster', :session_token => "#{SecureRandom.base64}", :Admin => false},
]
topics = [
  {:header => 'Best food in Iowa City', :subject => 'Food', :user_id => '2'},
  {:header => 'Best dog breeds', :subject => 'Dogs', :user_id => '2'},
  {:header => 'Favorite car brand', :subject => 'Cars', :user_id => '2'},
  {:header => 'Best Chinese restaurants', :subject => 'Food', :user_id => '3'},
  {:header => 'Best Operating system', :subject => 'Computers', :user_id => '3'},
  {:header => 'Best Cats', :subject => 'Cats', :user_id => '4'},
]
def request_ip
  if Rails.env.development?
    ip = '129.255.224.49'
  else
    ip = '129.255.224.49'
    # request.remote_ip
  end
end
users.each { |user| User.create!(user) }
topics.each do |topic|
  topic = Topic.new(topic)
  topic.ip_address = request_ip
  topic.geocode
  topic.save!
end
