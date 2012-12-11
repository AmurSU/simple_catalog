source 'https://rubygems.org'

gem 'rails', '~> 3.2.6'

gem 'pg'
gem 'active_scaffold'
gem 'devise', '~> 2.1.2'
gem 'haml'
gem 'russian'
gem 'whenever', '~> 0.7.3'
gem 'idn-ruby', :require => 'idn'
gem 'addressable'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.0.3.1'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '~> 3.11.8', :platforms => :ruby # For therubyracer
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

group :production do
  gem 'unicorn'

  # Backup automated system
  gem 'backup', '~> 3.0'
  gem 'net-ssh', '~> 2.3.0'
  gem 'net-scp'
  gem 'mail'
  gem 'dropbox-sdk', '~> 1.2.0'
end

group :development do
  gem "capistrano"
  gem "rvm-capistrano"
  gem 'debugger'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end
