require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # relationships macros...
  should belong_to(:owner)
  should have_many(:project_roles)

  # validation macros...
  should validate_presence_of(:title)
  should validate_presence_of(:status)
  should validate_presence_of(:genre)
  should validate_presence_of(:category)
  should validate_uniqueness_of(:title)
  should validate_inclusion_of(:status).in_array(%w[active hiatus finished cancelled])
  should validate_inclusion_of(:preview_level).in_array(%w[hidden by_invitation preview published])

  # additional tests for status (not essential)
  should allow_value("active").for(:status)
  should allow_value("hiatus").for(:status)
  should allow_value("finished").for(:status)
  should allow_value("cancelled").for(:status)
  should_not allow_value("bad").for(:status)
  should_not allow_value("hacker").for(:status)
  should_not allow_value(10).for(:status)
  should_not allow_value("leader").for(:status)
  should_not allow_value(nil).for(:status)
  should_not allow_value("").for(:status)

  # additional tests for date
  should allow_value(Date.today).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)
  should allow_value(nil).for(:end_date)
  should_not allow_value(1.day.from_now.to_date).for(:start_date)

  # validating title...
  should allow_value("Tell Me").for(:title)

  # validating category...
  should allow_value("Music").for(:category)
  should allow_value("Book").for(:category)

  # validating genre...
  should allow_value("Electronic").for(:genre)
  should allow_value("Fiction").for(:genre)

  # --------
  # Contexts

  context "Creating context for project" do
    
    setup do 
      create_users
      create_projects
      @tell_me.owner_id = @evan.id
      @tell_me.save!
    end

    teardown do 
      destroy_users
      destroy_projects
    end

    # test create...
    should "properly create factories" do
      assert_equal "Evan", @evan.first_name
      assert_equal "Tell Me", @tell_me.title
      assert_equal "Book", @hunger_games.category
      assert_equal false, @ev.active
    end

    should "have a active user as its owner" do
      assert_not_nil @tell_me.owner
      assert @tell_me.owner.active
    end

    # test scope alphabetical...
    should "show three projects in alphabetical order" do
      assert_equal ["All Of The Lights", "Hunger Games", "Light", "Tell Me"], Project.alphabetical.map{|p| p.title}
    end

    # test scope chronological...
    should "show three projects in chronological order" do
      assert_equal ["All Of The Lights", "Hunger Games", "Light", "Tell Me"], Project.chronological.map{|p| p.title}
    end

    # test scope for_user...
    should "have properly working scope for_owner" do
      assert_equal 1, Project.for_owner(@evan.id).all.size
    end

    # test scope for_category...
    should "have properly working scope for_category" do
      assert_equal 1, Project.for_category("Book").size
      assert_equal 3, Project.for_category("Music").size
    end

    # test scope for_genre...
    should "have properly working scope for_genre" do
      assert_equal 1, Project.for_genre("Fiction").size
      assert_equal 2, Project.for_genre("Electronic").size
    end

    should "have working active scope" do 
      assert_equal ["Tell Me"], Project.active.all.map(&:title).sort
    end

    should "have working completed scope" do 
      assert_equal ["All Of The Lights", "Hunger Games"], Project.completed.all.map(&:title).sort      
    end

    should "have a scope to return all projects with a similar title" do
      assert_equal ["Tell Me"], Project.for_title("tell me").all.map{|p| p.title}.sort
      assert_equal ["Hunger Games"], Project.for_title("hunger games").all.map{|p| p.title}.sort 
    end

    should "set end date of cancelled or completed project to today" do
      @cancel_project = FactoryGirl.build(:project, title: "Cancelled Project", category: "movie", genre: "thriller", status: "active", start_date: 1.day.ago)
      assert_equal nil, @cancel_project.end_date
      @cancel_project.status = "cancelled"
      @cancel_project.save!
      assert_equal Date.today, @cancel_project.end_date
      @cancel_project.destroy

      @finish_project = FactoryGirl.build(:project, title: "Finished Project", category: "movie", genre: "action", status: "active", start_date: 1.day.ago)
      assert_equal nil, @finish_project.end_date
      @finish_project.status = "finished"
      @finish_project.save!
      assert_equal Date.today, @finish_project.end_date
      @finish_project.destroy
    end

    should "verify project is not already in the system" do
      # uniqueness is Title+Owner
      @bad_project = FactoryGirl.build(:project, owner_id: @evan.id)
      assert_equal false, @bad_project.valid?
    end

    should "verify the end date is after the start date" do
      @bad_project = FactoryGirl.build(:project, title: "Eon", owner: @evan, genre: "Fantasy", start_date: 8.days.ago.to_date, end_date: 17.days.ago.to_date)
      assert_equal false, @bad_project.valid?
    end

    should "correctly calculate length of project" do
      # returns length of project as number of days
      # calculate start to end for complete/cancelled projects
      # calculate start to today for active/hiatus projects
      assert_equal 334, @hunger_games.length
      assert_equal 55, @light.length
    end
  end
end
