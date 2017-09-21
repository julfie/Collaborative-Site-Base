module Contexts
    module Projects
      def create_projects
        @Eon            = FactoryGirl.create(:project, owner_id: @evan)
        @EndersGame     = FactoryGirl.create(:project, owner_id: @juliann, title: "Ender's Game", genre: "science fiction")
        @EndersS        = FactoryGirl.create(:project, owner_id: @jim, title: "Ender's Shadow", genre: "science fiction")
        @Eragon         = FactoryGirl.create(:project, owner_id: @joe, title: "Eragon", genre: "fantasy", start_date: 1.year.ago.to_date , end_date: Date.today, status: "finished")
        @TPB            = FactoryGirl.create(:project, owner_id: @ev, title: "The Princess Bride", genre: "fantasy", start_date: 2.years.ago.to_date , end_date: 1.year.ago.to_date, status: "finished")
        @ml             = FactoryGirl.create(:project, owner_id: @ev, title: "My Life", genre: "autobiography", category: "nonfiction")
        @hunger_games   = FactoryGirl.create(:project, owner_id: @juliann, title: "Hunger Games", category: "Book", genre: "fiction", status: "finished", start_date: 1.year.ago, end_date: 1.month.ago)
      end
      
      def destroy_projects
        @Eon.destroy
        @EndersGame.destroy
        @EndersS.destroy
        @Eragon.destroy
        @TPB.destroy
        @hunger_games.destroy
      end
    end
  end