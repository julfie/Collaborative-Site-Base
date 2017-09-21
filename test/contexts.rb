# require needed files
require './test/sets/roles'
require './test/sets/users_roles'
require './test/sets/users'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::UserRoles
  include Contexts::Roles
  include Contexts::Users

end