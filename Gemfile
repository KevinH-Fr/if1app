source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data" #, platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'ransack'
gem 'kaminari'
gem "sassc-rails"
gem 'cloudinary'
gem "hotwire-rails"
gem 'wicked_pdf'

gem "wkhtmltopdf-binary", group: :development
gem "wkhtmltopdf-heroku", group: :production


group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "sqlite3", "~> 1.4"

end

group :production do
  gem 'pg', '~> 1.4', '>= 1.4.1'
  gem "wkhtmltopdf-heroku"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
