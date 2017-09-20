require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # relationships macros...
  should belong_to(:owner)
  should have_many(:project_roles)
  should have_many(:roles).through(:project_roles)
  should have_many(:users).through(:project_roles)

  # validation macros...
  should validate_presence_of(:title)
  should validate_presence_of(:status)
  should validate_presence_of(:genre)
  should validate_presence_of(:category)
  should validate_uniqueness_of(:title)
  should validate_inclusion_of(:status).in_array(%w[active hiatus finished cancelled])
  should validate_inclusion_of(:preview_level).in_array(%w[hidden by_invitation preview published])
  # should validate_date :start_date, :on_or_before => :today
  # should validate_date :end_date, :after => :start_date

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
  should allow_value(nil).for(:end_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  # should_not allow_value("bad").for(:start_date)
  # should_not allow_value(2).for(:start_date)
  # should_not allow_value(3.14159).for(:start_date)

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
      create_projects
      create_users
    end

    teardown do 
      destroy_projects
      destroy_users
    end

    # test create...
    should "properly create factories" do
      assert_equal "Evan", @evan.first_name
      assert_equal "Tell Me", @p1.title
      assert_equal "Book", @p2.category
      deny @john.active
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
      assert_equal ["Tell Me", "Hunger Games", "Light", "All Of The Lights"], Project.chronological.map{|p| p.title}
    end

    # test scope for_user...
    should "have properly working scope for_owner" do
      assert_equal @evan, Project.for_owner(@evan)
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
      assert_equal ["Hunger Games"], Project.active.all.map(&:title).sort
    end

    should "have working completed scope" do 
      assert_equal ["All Of The Lights", "Hunger Games"], Project.completed.all.map(&:title).sort      
    end

    should "have a scope to return all projects with a similar title" do
      assert_equal ["All Of The Lights", "Light"], Project.for_title("Light").title.all.map(&:title).sort 
      assert_equal ["All Of The Lights", "Light"], Project.for_title("ligh").title.all.map(&:title).sort 
    end

    should "set end date of cancelled or completed project to today" do
      @p1 = FactoryGirl.build(:project, status: "active")
      assert_equal nil, @p1.end_date
      @p1.set_status("cancelled")
      assert_equal Date.today, @p1.end_date

      @p2 = FactoryGirl.build(:project, status: "active")
      assert_equal nil, @p2.end_date
      @p2.set_status("finished")
      assert_equal Date.today, @p2.end_date
    end

    should "verify project is not already in the system" do
      # uniqueness is Title+Owner
      @bad_project = FactoryGirl.build(:project)
      deny @bad_project.valid?
    end

    should "verify the end date is after the start date" do
      @bad_project = FactoryGirl.build(:project, title: "Eon", owner: @evan, genre: "Fantasy", start_date: 8.days.ago.to_date, end_date: 17.days.ago.to_date)
      deny @bad_project.valid?
    end

    should "correctly calculate length of project" do
      # returns length of project as number of days
      # calculate start to end for complete/cancelled projects
      # calculate start to today for active/hiatus projects
      @p3 = FactoryGirl.build(:project, status: "finished", start_date: 31.days.ago, end_date: 1.day.ago)
      assert_equal 30, @p3.length
      @p4 = FactoryGirl.build(:project, status: "active", start_date: 7.days.ago)
      assert_equal 7, @p4.length
    end
  end
end
