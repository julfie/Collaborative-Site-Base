module Contexts
	module Projects
		def create_projects
			@tell_me = FactoryGirl.create(:project)
      		@hunger_games = FactoryGirl.create(:project, title: "Hunger Games", category: "Book", genre: "Fiction", status: "finished", start_date: 1.year.ago, end_date: 1.month.ago, preview_level: "published")
      		@light = FactoryGirl.create(:project, title: "Light", category: "Music", genre: "Electronic", status: "cancelled", start_date: 2.months.ago, end_date: 1.week.ago)
      		@all_of_the_lights = FactoryGirl.create(:project, title: "All Of The Lights", category: "Music", genre: "Hip Hop", status: "finished", start_date: 7.years.ago, end_date: 5.years.ago, preview_level: "published")
		end

		def destroy_projects
			@tell_me.destroy
			@hunger_games.destroy
			@light.destroy
			@all_of_the_lights.destroy
		end
	end
end