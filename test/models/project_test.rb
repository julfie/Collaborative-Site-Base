require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  # test relationships
  should belong_to(:owner)
  should have_many(:project_roles)
  should have_many(:roles).through(:project_roles)
  should have_many(:users).through(:project_roles)

  # test validations with matchers
  should validate_presence_of(:title)
  should validate_presence_of(:status)
  should validate_presence_of(:genre)
  should validate_presence_of(:category)
  should validate_uniqueness_of(:title)
  should validate_inclusion_of(:status).in_array(%w[active hiatus finished cancelled])
  should validate_inclusion_of(:preview_level).in_array(%w[hidden by_invitation preview published])
  # should validate_date :start_date, :on_or_before => :today
  # should validate_date :end_date, :after => :start_date, :after_message => "end date cannot be before start date", :allow_nil

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
  should allow_value(Date.current).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)


  # validating title...
  should allow_value("Tell Me").for(:title)
  
    # validating category...
    should allow_value("Music").for(:category)
    should allow_value("Book").for(:category)
  
    # validating genre...
    should allow_value("Electronic").for(:genre)
    should allow_value("Fiction").for(:genre)
  
  context "Within context" do
    setup do 
      create_users
      create_projects
    end
    
    teardown do
      destroy_users
      destroy_projects
    end

    should "have a active user as its owner" do
      assert_not_nil @Eon.owner_id
      ownr = Person.find(@Eon.owner_id)
      assert ownr.active
      assert @Eon.valid?

      ownr.make_inactive
      deny @Eon.valid?
    end

    should "have a scope to list projects in alphabetical order" do
      assert_equal ["Ender's Game", "Ender's Shadow", "Eon", "Eragon", "Hunger Games", "My Life", "The Princess Bride"], Project.alphabetical.all.map(&:title)
    end

    should "have a scope to list projects chronologically" do
      assert_equal ["The Princess Bride", "Eragon", "Hunger Games", "Eon", "Ender's Game", "Ender's Shadow", "My Life"], Project.chronological.all.map(&:title)
    end

    should "have working active scope" do 
      assert_equal ["Ender's Game", "Ender's Shadow", "Eon", "My Life"], Project.active.all.map(&:title).sort
    end

    should "have working completed scope" do 
      assert_equal ["Eragon", "Hunger Games", "The Princess Bride"], Project.completed.all.map(&:title).sort      
    end

    should "have a scope to return all projects with a similar title" do
      assert_equal ["Ender's Game", "Ender's Shadow"], Project.for_title("Ender").all.map(&:title).sort 
      assert_equal ["Ender's Game", "Ender's Shadow"], Project.for_title("ende").all.map(&:title).sort 
    end

    should "have a scope to search by category" do
      assert_equal ["My Life"], Project.for_category("nonfiction").all.map(&:title).sort 
      assert_equal ["Hunger Games"], Project.for_category("Book").all.map(&:title).sort 
      assert_equal ["Ender's Game", "Ender's Shadow", "Eon","Eragon", "The Princess Bride"], Project.for_category("fiction").all.map(&:title).sort 
    end 

    should "have a scope to search by genre" do
      assert_equal ["Ender's Game", "Ender's Shadow"], Project.for_genre("science fiction").all.map(&:title).sort 
      assert_equal ["Eon", "Eragon", "The Princess Bride"], Project.for_genre("fantasy").all.map(&:title).sort 
    end

    should "have scope to search by owner" do
      assert_equal [@EndersGame.title], Project.for_owner(@evan).all.map(&:title).sort 
    end

    should "verify project is not already in the system" do
      # uniqueness is Title+Owner
      @bad_project = FactoryGirl.build(:project, title: "Eon", owner: @juliann, genre: "Fantasy", start_date: Date.new(2017, 2, 1) , end_date: Date.new(2018, 1, 1))
      deny @bad_project.valid?
    end 

    should "verify the end date is after the start date" do
      @bad_project = FactoryGirl.build(:project, title: "Eon", owner: @juliann, genre: "Fantasy", start_date: 8.days.ago.to_date, end_date: 17.days.ago.to_date)
      deny @bad_project.valid?
    end 

    should "set end date of cancelled or completed project to today" do
      # callback to check is cancelled or completed (set end date to today)
      @ml.cancel
      assert_equal @ml.end_date, Date.today
      @EndersGame.status = "finished"
      @EndersGame.save!
      assert_equal Date.today, @EndersGame.end_date
    end

    should "correctly calculate length of project" do
      # returns length of project as number of days
      # caculate start to end for complete/cancelled projects | start to today for active/hiatus projects
      assert_equal 334, @hunger_games.time_length
      assert_equal 1, @EndersGame.time_length
      assert_equal 1, @Eon.time_length
      @Eon.start_date = 5.days.ago.to_date
      assert_equal 5, @Eon.time_length
    end

  end
end
