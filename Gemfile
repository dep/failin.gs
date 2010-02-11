source 'http://gemcutter.org'

# Rails
gem "rails", git: "git://github.com/rails/rails.git"

# Configuration
gem "mysql"
gem "rerails",   git: "git://github.com/stephencelis/rerails.git"
gem "authlogic", git: "git://github.com/binarylogic/authlogic.git"
gem "aasm",      git: "git://github.com/stephencelis/aasm.git"

group :development do
  gem "ghi"
  gem "capistrano"
  gem "heroku"
end

group :production do
  gem "daemons", require: false
  gem "rack-cache"
end
