require 'test_helper'

class ProjectRoleTest < ActiveSupport::TestCase
 # test relationships
  should belong_to(:user)
  should belong_to(:role)
  should belong_to(:project)

  # test validations with matchers
  should validate_presence_of(:role_id)
  should validate_presence_of(:invite_num)
  should validate_numericality_of(:invite_num).is_greater_than_or_equal_to(0)

  context "Within context" do
    setup do 
      create_users
      create_projects
      create_roles
      create_project_roles
    end
    
    teardown do
      destroy_users
      destroy_projects
      destroy_roles
      destroy_project_roles
    end

    should "have a scope to alphabetize by user" do
      assert_equal ["Albert", "Evan", "Juliann"], ProjectRoles.by_user.map{r|r.user}
    end

    should "have a scope to alphabetize by role" do
      assert_equal ["artist", "Editor", "Writer"], ProjectRoles.by_role
    end

    should "have a scope to alphabetize by project" do
      assert_equal ["Ender's Game", "Ender's Shadow", "Eon"], ProjectRoles.by_project.map{r|r.project.name}
    end

    should "have a scope to return filled roles" do
      assert_equal ["editor", "writer"], ProjectRoles.filled.all.map(&:name).sort
    end 
    
    should "have a scope to return empty roles" do
      assert_equal [@p3], ProjectRoles.empty
    end

    should "only allow empty roles to be destroyed" do
      assert @p1.user_id
      deny @p1.destroyed?

      assert_nil @p3.user_id
      @p3.destroy
      assert_nil @p3
    end

  end
end
