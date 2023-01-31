source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4.1'

# Use mysql as the database for Active Record
gem 'active_storage_validations', '0.9.8'

gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'

# Use devise for Users and authentication.
gem 'devise', '~> 4.8'
gem 'devise-i18n'
gem 'dotenv-rails', '~> 2.8'

gem 'bcrypt', '3.1.18'
gem 'bootsnap', '1.12.0', require: false
gem "bootstrap-sass", '3.4.1'

# For generating fake seeding data.
gem 'faker', '~> 3.1.0'

gem 'image_processing', '1.12.2'
gem 'importmap-rails', '1.1.0'
gem 'sassc-rails', '2.1.2'
gem 'sprockets-rails', '3.4.2'
gem 'stimulus-rails', '1.0.4'
gem 'turbo-rails', '1.1.1'

# Use kaminari
gem 'kaminari', '~> 1.2'
gem 'kaminari-i18n', '~> 0.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Pry for debugging
  gem 'pry', '~> 0.14'
  gem 'pry-rails', '~> 0.3'

  # Rspec
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 6.0' # Tips: https://qiita.com/amatsukix/items/578f85cf4565ca2a797c
  gem 'spring-commands-rspec', '~> 1.0'

  #  RuboCop
  gem 'rubocop', '~> 1.43'
  gem 'rubocop-rails', '~> 2.17'

  # デバッグbinding.pry Doc: https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-byebug', '~> 3.9'
end

group :development do
  gem 'pre-commit'
  gem 'spring'
  gem 'web-console', '4.2.0'
end

group :test do
  # featuretテスト用
  gem 'capybara', '~> 3.38'
  gem "database_cleaner", '~> 2.0'
  gem 'selenium-webdriver', '~> 4.7'
end

group :production do
  gem 'aws-sdk-s3', '1.113.0', require: false
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
