module Contexts
  module UserRoles
    # Context for both customer and employee users
    def create_user_artist_roles
      @bobby_a = FactoryGirl.create(:user_role, user: @bobby , role: @artist)
      @obeezy_a   = FactoryGirl.create(:user_role, user: @obeezy, role: @artist)
      @fakey_a  = FactoryGirl.create(:user_role, user: @fakey, role: @artist)
      @lazy_a     = FactoryGirl.create(:user_role, user: @lazy, role:  @artist) 
    end
    
    def destroy_user_artist_roles
      @bobby_a.delete
      @obeezy_a.delete
      @fakey_a.delete
      @lazy_a.delete 
    end

    def create_user_producer_roles
      @bibby_p = FactoryGirl.create(:user_role, user: @bibby, role: @producer)
      @dean_p   = FactoryGirl.create(:user_role, user: @dean, role:  @producer)
    end
    
    def destroy_user_producer_roles
      @bibby_p.delete
      @dean_p.delete
    end

    def create_user_mixer_roles
      @mike_p  = FactoryGirl.create(:user_role, user: @mike, role: @mixer)
    end
    
    def destroy_user_mixer_roles
      @mike_p.delete
    end

  end

end