source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.5.5'

#Geo-coding gem for location service
gem 'geocoder'

# gem 'wdm'
# gem 'wdm', '>= 0.1.0' if Gem.win_platform?

# for upvotes
gem 'acts_as_votable'


# Timezone data for windows users
gem 'tzinfo-data', platforms: %i[mri mingw x64_mingw]
# password encryption and decryption
gem 'bcrypt'

gem 'haml'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use Puma as the app server
#gem 'puma', '~> 3.11' #if you're windows then run {gem install puma -v '3.12.1' -- --with-cppflags=-I/usr/local/opt/openssl/include}
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# gem 'wdm'
# Reduces boot times through caching; required in config/boot.rb
#gem 'bootsnap', '>= 1.1.0', require: false unless (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'guard-rspec'
  gem 'simplecov'
  gem 'jasmine-rails'
  gem 'launchy'
  gem 'rspec', '~>3.5'
  gem 'rspec-rails'
  gem 'sqlite3', git: "https://github.com/larskanis/sqlite3-ruby", branch: "add-gemspec"
  gem 'omniauth-google-oauth2'
  gem 'devise'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec-expectations'
  # gem 'simplecov'
end


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :production do
  gem 'omniauth-google-oauth2'
  gem 'pg', '~> 0.15'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# TODO remove later platforms(%i[mingw mswin x64_mingw jruby]) { gem 'tzinfo-data', group: [:development] }

# TODO Remove Later
#platforms :mswin do
#  gem 'wdm', group: %i[development test]
#end
