module Contexts
	module Messages
		def create_messages
      		@greetings = FactoryGirl.create(:message, sender: @evan)
      		@thanks = FactoryGirl.create(:message, sender: @ev, send_date: 1.day.ago, subject: "Thanks", body: "Hello! Thank you for your help!", read_status: false)
      		@invite = FactoryGirl.create(:message, sender: @jim, flagged: true, send_date: 1.week.ago, subject: "Project Invite", body: "Hello! You've been invited to work on a new project!", invite_code: "qwertyuiop1234")
		end

		def destroy_messages
			@greetings.destroy
			@thanks.destroy
			@invite.destroy
		end
	end
end