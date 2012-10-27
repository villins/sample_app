require 'faker'
namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		admin = User.create!(:name => "Example User",
			:email => "example@126.org",
			:password => "111111",
			:password_confirmation => "111111")
		admin.toggle!(:admin)
	99.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(:name => name,
			:email => email,
			:password => password,
			:password_confirmation => password)
		end
	end
end
