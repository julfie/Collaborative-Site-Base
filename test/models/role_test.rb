require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  

	#test relationships
	## should have_many(:project_roles)
	## should have_many(:user_roles)

	#test validation matchers
	should validate_presence_of(:name)
	#should allow_nil.for(:description)



    context "Within context" do

    setup do 
      create_roles      
    end
    
    teardown do
      destroy_roles
    end

    #write tests for active role (active, inactive, make_active, make_inactive)

    should "have a working scope called inactive" do
      
      assert_equal ['instrumentalist'], Role.inactive.all.map(&:name)
      
    end

    should "have a working scope called active" do
      assert_equal ['artist', 'producer', 'mixer'], Role.active.all.map(&:name)
    end

    should "have a working method called make_active" do
       @role1 = FactoryGirl.create(:role, name: 'artist', description: 'The owner of the song', active: false ) 
       @role1.make_active
       assert @role1.active?
       @role1.destroy

    end

    should "have a working method called make_inactive" do
        @role2 = FactoryGirl.create(:role, name: 'bop', description: 'The owner of the song', active: false ) 
        @role2.make_inactive
        deny @role2.active?
        @role2.destroy
    end    

	end
end
