# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "activemodel", require: "active_model"

group :development, :test do
  gem "byebug"
  gem "ipaddress"
  gem "rubocop"
  gem "simplecov", require: false, group: :test
end

group :test do
  gem "shoulda-matchers"
end
