require './test/sets/messages'
require './test/sets/users'
require './test/sets/projects'

module Contexts
	include Contexts::Messages
	include Contexts::Users 
	include Contexts::Projects
end