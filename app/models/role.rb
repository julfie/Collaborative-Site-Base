class Role < ActiveRecord::Base
	include Activeable

	# Relationships
	  has_many :user_roles
	  has_many :project_roles

	  # Scopes
	  
	  scope :active,        -> { where(active: true) }
	  scope :inactive,      -> { where(active: false) }
	  
	  

	  # Validations

	  validates_presence_of :name
	  

	  # Methods

end
