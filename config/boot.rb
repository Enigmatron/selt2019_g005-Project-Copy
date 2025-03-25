ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
#require 'bootsnap/setup' unless (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/) # Speed up boot time by caching expensive operations.
