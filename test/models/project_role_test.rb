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

    should "have a scope to return filled roles" do
          assert_equal ["mixer", "producer"], ProjectRole.filled.all.map{|p| p.role.name}.sort
        end

    should "have a scope to return empty roles" do
      assert_equal [@pr3], ProjectRole.empty
    end

    should "have a scope to alphabetize by user" do
      assert_equal ["Juliann", "Jim" ], ProjectRole.by_user.map{|r| User.find(r.user_id).f_name}
    end

    should "have a scope to alphabetize by role" do
      assert_equal ["mixer", "artist", "producer"], ProjectRole.by_role.map{|r| Role.find(r.project_id).name}
    end

    should "have a scope to alphabetize by project" do
      assert_equal ["Ender's Game", "Ender's Shadow", "Eon"], ProjectRole.by_project.map{|r| Project.find(r.project_id).title}
    end

    should "only allow empty roles to be destroyed" do
      assert @pr1.user_id
      deny @pr1.destroyed?

      assert_nil @pr3.user_id
      @pr3.destroy
      assert @pr3
        end

  end
end
