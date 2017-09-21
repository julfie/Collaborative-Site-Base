module Contexts
  module Roles
    # Context for both customer and employee roles
    def create_roles
      @artist   = FactoryGirl.create(:role, name: 'artist' , description: 'The owner of the song' ) 
      @producer   = FactoryGirl.create(:role, name: 'producer',  description: 'A user who produces beats, can specficy what beats kind of beats they specialize in') 
      @mixer  = FactoryGirl.create(:role, name: 'mixer',  description: 'A user who can mix and master songs') 
      @instrumental     = FactoryGirl.create(:role, name: 'instrumentalist',  description: 'A user that specializes in a certain instrument', active: false) 
    end
    
    def destroy_roles
      @artist.delete
      @producer.delete
      @mixer.delete
      @instrumental.delete 

    end


  end
  
end   