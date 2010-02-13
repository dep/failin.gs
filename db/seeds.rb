# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user = User.new login: "failings",
                email: "app@failin.gs",
             password: "password",
              surname: "Gs"

user.invites_left = 5000
user.send :reset_single_access_token # Because null: false.
user.save validate: false
