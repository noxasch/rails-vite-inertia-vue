source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails", "~> 6.1.0"
  gem "factory_bot_rails", "~> 6.4"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "annotate", "~> 3.2"
  gem "solargraph", "~> 0.50.0", require: false
  gem "solargraph-rails", "~> 1.1", require: false
  gem "js_from_routes", "~> 3.0"
end


gem "vite_rails", "~> 3.0"
gem "inertia_rails", "~> 3.2"
gem "inertia_rails-contrib", "~> 0.1.1"

gem "devise", "~> 4.9"
gem "cancancan", "~> 3.6"
