require 'test_helper'

class UserRoleTest < ActiveSupport::TestCase
  
	#test relationships
	should belong_to(:user)
	should belong_to(:role)

	#test validation matchers
	
    # validate presence of user_id and role_id
    # --------------------------------------------

    should validate_presence_of(:user_id)
    should validate_presence_of(:role_id)


	
end
