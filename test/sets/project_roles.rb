module Contexts
    module Project_Roles
      def create_project_roles
        @p21     = FactoryGirl.create(:project_role)
        @pr2     = FactoryGirl.create(:project_role, project_id: @EndersGame, role_id: @writer, user_id: @jim, invite_num: 2)
        @pr3     = FactoryGirl.create(:project_role, project_id: @EndersS, role_id: @artist, user_id: nil, invite_num: 3)
    end
      
      def destroy_project_roles
        @pr1.destroy
        @pr2.destroy
        @pr3.destroy
      end
    end
  end