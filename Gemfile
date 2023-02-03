# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in kanal-interfaces-discord.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "kanal"

gem 'discordrb', github: 'shardlab/discordrb', branch: 'main'

group :development do
  gem "rubocop", "~> 1.21"
  gem "ruby-debug-ide"
  gem "solargraph"
  gem "yard"
end

group :test do
  gem "simplecov", require: false
end
