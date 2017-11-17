source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.4.2'

gem 'acts_as_list'
gem 'devise'
gem 'devise_token_auth'
gem 'image_processing'
gem 'jsonapi-utils'
gem 'lol_dba'
gem 'mini_magick', '>= 4.3.5'
gem 'omniauth'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'pundit', github: 'elabs/pundit'
gem 'rack-cors'
gem 'rails', '~> 5.1.4'
gem 'shrine'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'jsonapi-resources-matchers'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'inquisition', github: 'rubygarage/inquisition'
  gem 'json_spec'
  gem 'rswag'
end

gem 'rails_12factor', group: :production
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
