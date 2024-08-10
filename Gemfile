source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "~> 7.2.0"

gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "pg"
gem "puma"
gem "redis"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
