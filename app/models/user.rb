class User < ActiveRecord::Base
	include Activeable
	before_save :reformat_phone
	has_secure_password

	# relationships
	has_many :messages
	has_many :projects
	has_many :user_roles
	has_many :project_roles

	# scopes
	scope :alphabetical, -> { order('last_name').order('first_name') }
	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }
	scope :search, ->(term) { where('first_name LIKE lower(?) OR last_name LIKE lower(?)', "#{term.downcase}%", "#{term.downcase}%") }

	# validations
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :email
	validates_presence_of :username
	validates_presence_of :phone_number
	validates_presence_of :password, on: :create
	validates_presence_of :password_confirmation, on: :create
	validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
	validates_uniqueness_of :email
	validates_uniqueness_of :username
	validates_format_of :phone_number, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
	validates_confirmation_of :password, message: "doesn't match confirmation"
	validates_length_of :password, minimum: 6

	def name
		first_name + " " + last_name
	end

	private

	def reformat_phone
		phone_number = self.phone_number.to_s
		phone_number.gsub!(/[^0-9]/,"")
		self.phone_number = phone_number
	end
end
