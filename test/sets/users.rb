module Contexts   
  module Users
    # Context for both customer and employee users

     def create_users
      @evan = FactoryGirl.create(:user, f_name: "E", l_name: "Man", username: "eman", email: "eman@cmuis.net", phone: "443-410-4122")
      @ev = FactoryGirl.create(:user, f_name: "Ev", l_name: "Smith", username: "esmith", email: "esmith@esmith.com", phone: "412.214.4124", active: false)
      @joe = FactoryGirl.create(:user, f_name: "Joe", l_name: "Shmoe", username: "jshmoe", email: "jshmoe@cmuis.net", phone: "(443) 410-4122")
      @jim = FactoryGirl.create(:user, f_name: "Jim", l_name: "Sim", username: "jsim", email: "jsim@andrew.cmu.edu")
      @juliann = FactoryGirl.create(:user, f_name: "Juliann", l_name: "Fields", username: "jbfields", email: "jbfields@andrew.cmu.edu")
    end

    def destroy_users
      @evan.destroy
      @ev.destroy
      @joe.destroy
      @jim.destroy
      @juliann.destroy
    end

    def create_artists_users
      @bobby   = FactoryGirl.create(:user, f_name: "Bobby", l_name: "Barnes", username: "bbarnes", phone: "893-268-2323", email: 'bbarnes@gmail.com')
      @obeezy   = FactoryGirl.create(:user, f_name: "Obeezy", l_name: "Eezy", username: "obeezy", phone: "347-268-2323", email: 'obeezy@gmail.com')
      @fakey  = FactoryGirl.create(:user, f_name: "Fakey", l_name: "Lady", username: "fakey", phone: "412-568-2323", email: 'fakeyjakey@gmail.com')
      @lazy     = FactoryGirl.create(:user, f_name: "Lazy", l_name: "Junker", username: "ljunker", phone: "718-228-2323", email: 'lazyj@gmail.com')
    end
    
    def destroy_artists_users
      @bobby.delete
      @obeezy.delete
      @fakey.delete
      @lazy.delete 

    end

    def create_producers_users
      @bibby    = FactoryGirl.create(:user, f_name: "Lil", l_name: "Bibby", username: "lilbibby", phone: "728-228-2323", email: 'bibs@gmail.com')
      @dean     = FactoryGirl.create(:user, f_name: "Dean", l_name: "DaBean", username: "beandean", phone: "412-268-8211", email: 'dabean@gmail.com')
      @mike     = FactoryGirl.create(:user, f_name: "Mike", l_name: "Deeeno", username: "mikeike", phone: "728-228-2323", email: 'deeebs@gmail.com')

    end

    def destroy_producers_users
      @bibby.delete
      @dean.delete
      @mike.delete
    end

    def create_inactive_users
      @bad_user1 = FactoryGirl.create(:user, f_name: "Barney", l_name: "Barnes", active: 'false', email: 'barney@gmail.com', username: "bbbarney" )
      @bad_user2 = FactoryGirl.create(:user, f_name: "Harry", l_name: "Barnes", active: 'false', email: 'harry@gmail.com', username: "hbarnes" )
      @bad_user3 = FactoryGirl.create(:user, f_name: "Cat", l_name: "Barnes", active: 'false', email: 'cat@gmail.com', username: "catbbb" )
    end

    def destroy_inactive_users
      @bad_user1.delete
      @bad_user2.delete
      @bad_user3.delete
    end

  end
end  