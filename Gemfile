source 'http://gemcutter.org'

# Suppress warnings
gem "bundler",         require: nil
gem "rubygems-update", require: nil

# Rails
gem "rails", git: "git://github.com/rails/rails.git"

# Configuration
gem "mysql"
gem "aasm",      git: "git://github.com/rubyist/aasm.git"
gem "authlogic", git: "git://github.com/binarylogic/authlogic.git"
gem "rack-oauth"
gem "rerails",   git: "git://github.com/stephencelis/rerails.git"
gem "uuid"

group :development do
  gem "ghi"
  gem "capistrano"
  gem "heroku"
end

group :test do
  gem "miniskirt"
end

group :production do
  gem "daemons"
end
