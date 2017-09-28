# require needed files
require './test/sets/roles'
require './test/sets/users_roles'
require './test/sets/users'
require './test/sets/projects'
require './test/sets/project_roles'
require './test/sets/messages'

module Contexts
  # explicitly include all sets of contexts used for testing
  include Contexts::UserRoles
  include Contexts::Roles
  include Contexts::Users
  include Contexts::Projects
  include Contexts::ProjectRoles
  include Contexts::Messages

end
