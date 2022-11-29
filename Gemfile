source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"
gem 'dotenv-rails'
gem "image_processing",           "1.12.2"
gem "faker",                      "2.21.0"
gem "active_storage_validations", "0.9.8"
gem "bcrypt",                     "3.1.18"
gem "sassc-rails",                "2.1.2"
gem "sprockets-rails",            "3.4.2"
gem "importmap-rails",            "1.1.0"
gem "turbo-rails",                "1.1.1"
gem "stimulus-rails",             "1.0.4"
gem "jbuilder",                   "2.11.5"
gem "puma",                       "5.6.4"
gem "bootsnap",                   "1.12.0", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Rspec
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
  gem 'rspec-rails' # Tips: https://qiita.com/amatsukix/items/578f85cf4565ca2a797c

  #  RuboCop
  gem 'rubocop'
  gem 'rubocop-rails'

  # デバッグbinding.pry Doc: https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-byebug', '~> 3.9'
end

group :development do
  gem "web-console", "4.2.0"
  gem 'spring'
end

group :test do
end

group :production do
  gem "aws-sdk-s3", "1.113.0", require: false
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
