module Contexts
    module ProjectRoles
      def create_project_roles
        @pr1     = FactoryGirl.create(:project_role, project_id: @Eon.id, role_id: @mixer.id, user_id: @jim.id)
        @pr2     = FactoryGirl.create(:project_role, project_id: @EndersGame.id, role_id: @producer.id, user_id: @juliann.id, invite_num: 2)
        @pr3     = FactoryGirl.create(:project_role, project_id: @EndersS.id, role_id: @artist.id, user_id: nil, invite_num: 3)
    end

      def destroy_project_roles
        @pr1.destroy
        @pr2.destroy
        @pr3.destroy
      end
    end
  end
