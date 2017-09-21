require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # relationships macros...
  should have_many(:user_roles)
  should have_many(:project_roles)
  should have_many(:messages)
  should have_many(:projects)

  # validation macros...
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)
  should validate_presence_of(:password)
  should validate_presence_of(:phone_number)

  # validating email...
  should allow_value("evan@evan.com").for(:email)
  should allow_value("evan@andrew.cmu.edu").for(:email)
  should allow_value("im_evan@evan.org").for(:email)
  should allow_value("evan123@evan.gov").for(:email)
  should allow_value("im.evan@evan.net").for(:email)

  # validating phone...
  should allow_value("5555555555").for(:phone_number)
  should allow_value("555-555-5555").for(:phone_number)
  should allow_value("555.555.5555").for(:phone_number)
  should allow_value("(555) 555-5555").for(:phone_number)

  should_not allow_value("1234567").for(:phone_number)
  should_not allow_value("12345678900").for(:phone_number)
  should_not allow_value("800-GOT-MILK").for(:phone_number)
  should_not allow_value("555/555/5555").for(:phone_number)
  should_not allow_value("555-5555-555").for(:phone_number)

  # validating password...
  should allow_value("Password1!").for(:password)
  should have_secure_password

  # --------
  # Contexts

  context "Creating context for user" do
    
    setup do 
      create_users
    end

    teardown do 
      destroy_users
    end

    # test create...
    should "properly create factories" do
      assert_equal "Evan", @evan.first_name
      assert_equal "Ev", @ev.first_name
      assert_equal "Joe", @joe.first_name
      assert @evan.active
      assert @joe.active
      deny @ev.active
    end

    # test scope alphabetical...
    should "show three users in alphabetical order" do
      assert_equal ["Ev", "Evan", "Jim", "Joe"], User.alphabetical.map{|u| u.first_name}
    end

    # test scope active...
    should "show that there are three active users" do
      assert_equal 3, User.active.size
      assert_equal ["Evan", "Jim", "Joe"], User.active.map{|u| u.first_name}.sort
    end

    # inactive
    should "show that there is one inactive user" do
      assert_equal 1, User.inactive.size
      assert_equal ["Ev"], User.inactive.map{|u| u.first_name}.sort
    end

    # test make_active/make_inactive
    should "test make_active method" do
      @u1 = FactoryGirl.build(:user, active: false, username: "u123", email: "u123@gmail.com")
      @u1.make_active
      assert_equal true, @u1.active
    end

    should "test make_inactive method" do
      @u2 = FactoryGirl.build(:user, active: true, username: "u456", email: "u456@gmail.com")
      @u2.make_inactive
      assert_equal false, @u2.active
    end

    # test scope search...
    should "show results matching part of or same as first or last name" do
      assert_equal 1, User.search("Evan").size
      assert_equal 1, User.search("evan").size
      assert_equal 2, User.search("e").size
    end

    # test name method...
    should "show that name method works" do 
      assert_equal "Evan Byrd", @evan.name
    end

    # test reformat phone callback
    should "show phone number without non-digits" do
      assert_equal "4104400887", @evan.phone_number
    end
  end
end
