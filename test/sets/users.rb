module Contexts
	module Users
		def create_users
			@evan = FactoryGirl.create(:user)
      		@ev = FactoryGirl.create(:user, first_name: "Ev", last_name: "Smith", username: "esmith", email: "esmith@esmith.com", phone_number: "412.214.4124", active: false)
      		@joe = FactoryGirl.create(:user, first_name: "Joe", last_name: "Shmoe", username: "jshmoe", email: "jshmoe@cmuis.net", phone_number: "(443) 410-4122")
      		@jim = FactoryGirl.create(:user, first_name: "Jim", last_name: "Sim", username: "jsim", email: "jsim@andrew.cmu.edu")
		end

		def destroy_users
			@evan.destroy
			@ev.destroy
			@joe.destroy
			@jim.destroy
		end
	end
end