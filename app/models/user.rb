class User < ActiveRecord::Base
	include Activeable
	before_save :reformat_phone
	# use has_secure_password
	  has_secure_password

	  # Relationships
	  has_many :user_roles
	  has_many :project_roles
	  has_many :projects, through: :project_roles
	  has_many :messages

	  # Scopes
	  scope :alphabetical,  -> { order(:l_name).order(:f_name) }
	  scope :active,        -> { where(active: true) }
	  scope :inactive,      -> { where(active: false) }
	  # scope :search_by,    ->(name) { where('f_name LIKE ?', "%#{name}" ) }

	  # Validations

	  validates_presence_of :f_name
	  validates_presence_of :l_name
	  validates :username, presence: true, uniqueness: { case_sensitive: false}
	  validates_presence_of :password, on: :create
  	validates_presence_of :password_confirmation, on: :create
  	validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
  	validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }

  	validates_confirmation_of :password, message: "doesn't match confirmation"
  	validates_length_of :password, minimum: 6


	  # Methods

	#   def role? (role)
	#   	stuff = self.user_roles.map { |ur|  ur.role }.include?(role);
	#   	puts stuff
	#   	if self.user_roles.map { |ur|  ur.role }.include?(role);
	#   		return true
	#   	else
	#   		return false
	#   	end
	# end

	  def reformat_phone
	  	phone = self.phone.to_s  # change to string in case input as all numbers
    	phone.gsub!(/[^0-9]/,"") # strip all non-digits
    	self.phone = phone       # reset self.phone to new string
	  end

	  def name
    	"#{f_name} #{l_name}"
  	  end



end
