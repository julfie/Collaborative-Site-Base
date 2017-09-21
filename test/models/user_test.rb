require 'test_helper'

class UserTest < ActiveSupport::TestCase
  



	#test relationships
	# should have_many(:project_roles)
	should have_many(:user_roles)
  should have_secure_password


	#test validation matchers

	should validate_presence_of(:username)
	should validate_presence_of(:f_name)
	should validate_presence_of(:l_name)
	should validate_presence_of(:email)
	should validate_uniqueness_of(:username).case_insensitive
	should validate_uniqueness_of(:email).case_insensitive

	should allow_value("4122683259").for(:phone)
    should allow_value("412-268-3259").for(:phone)
    should allow_value("412.268.3259").for(:phone)

    should allow_value(nil).for(:phone)
    should_not allow_value("2683259").for(:phone)
    should_not allow_value("14122683259").for(:phone)
    should_not allow_value("4122683259x224").for(:phone)

  context "Within context" do
    setup do 
      
      create_artists_users
      create_producers_users

    end
    
    teardown do
      destroy_artists_users
      destroy_producers_users
    end

    should "verify that the user is active in the system by defaut" do
      @new_user = FactoryGirl.build(:user, f_name: "Barney", l_name: "Barnes")
      assert @new_user.valid?
    end 


    should "have a working scope called inactive" do
      create_inactive_users
      assert_equal ['Barney', 'Cat','Harry'], User.inactive.all.map(&:f_name).sort
      destroy_inactive_users
    end

    should "have a working scope called active" do
      create_inactive_users
      assert_equal ["Bobby", "Dean", "Fakey", "Lazy", "Lil", "Mike", "Obeezy"], User.active.all.map(&:f_name).sort
      destroy_inactive_users
    end


    should "have a working scope called alphabetical" do
      assert_equal ["Bobby", "Lil", "Dean", "Mike", "Obeezy", "Lazy", "Fakey"], User.alphabetical.all.map(&:f_name)
    end

    ## scope for search_by fragment of last or first name



    ## methods: make_active, make_inactive, reformat_phone, 

    # should "have a working role? method" do 
    #   create_roles
    #   create_user_artist_roles
    #   create_user_producer_roles
    #   assert @bibby.role?(:producer)
    #   deny @bibby.role?(:artist)
    #   destroy_roles
    #   destroy_user_artist_roles
    #   destroy_user_producer_roles

    # end

    should "have a working method called make_active" do
       @new_user = FactoryGirl.create(:user, f_name: "Boosie", l_name: "Barnes", active: false)
       @new_user.make_active
       
       assert @new_user.active?
       @new_user.destroy

    end

    should "have a working scope called make_inactive" do
        @new_user2 = FactoryGirl.create(:user, f_name: "Barney", l_name: "Barnes", active: true)
        @new_user2.make_inactive
        deny @new_user2.active?
        @new_user2.destroy
    end 

    # should "have working search_by scope" do
      
    #   assert_equal ['Obeezy'], User.search_by("Obee").all.map(&:f_name)
    # end

    should "shows that Bibby's phone is stripped of non-digits" do
      assert_equal "7282282323", @bibby.phone
    end



	end


end
