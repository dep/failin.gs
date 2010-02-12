Factory.define :abuse do |f|
  f.content { Factory :failing }
  f.reporter_ip "127.0.0.%d"
end

Factory.define :comment do |f|
  f.failing { Factory :failing }
  f.text <<TEXT
This is so untrue!
TEXT
  f.submitter_ip "127.0.0.%d"
end

Factory.define :email do |f|
  f.address "johndoe%d@example.com"
end

Factory.define :failing do |f|
  f.user { Factory :user }
  f.submitter_ip "127.0.0.%d"
  f.about <<TEXT
You breath blows.
TEXT
  f.surname { |failing| failing.user.surname }
end

Factory.define :invitation do |f|
  f.inviter { Factory :user }
  f.email "janedoe%d@example.com"
end

Factory.define :promotion do |f|
  f.code "MASHABLE%d"
end

Factory.define :share do |f|
  f.user { Factory :user }
  f.emails "jimdoe@example.com, jendoe@example.com"
end

Factory.define :user do |f|
  f.login "jd%d"
  f.email "%{login}@example.com"
  f.password f.password_confirmation("password12")
  f.surname "Doe"
  f.location "Chicago"
  f.about <<TEXT
I'm a man with a plan!
TEXT
  f.subscribe true
  f.private false
  f.promotion { Factory :promotion } if App.beta?
end

Factory.define :vote do |f|
  f.failing { Factory :failing }
  f.agree true
  f.voter_ip "127.0.0.%d"
end
