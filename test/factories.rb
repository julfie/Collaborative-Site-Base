FactoryGirl.define do
	factory :message do
		subject "Greetings"
		body "Hello, my name is Evan"
		read_status true
		send_date 3.days.ago
		flagged false
	end

	factory :project do
		title "Tell Me"
		category "Music"
		genre "Electronic"
		status "active"
		preview_level "hidden"
		start_date Date.today
	end

	factory :user do
		first_name "Evan"
		last_name "Byrd"
		email "ebyrd@andrew.cmu.edu"
		phone_number "410-440-0887"
		username "ebyrd"
		password "Secret1!"
		password_confirmation "Secret1!"
		active true
	end
end