class Project < ActiveRecord::Base
	before_save :is_ended?
	# relationships
	belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
	has_many :project_roles
	has_many :roles, through: :project_roles
	has_many :users, through: :project_roles

	# scope
	scope :alphabetical, -> { order('title') }
	scope :chronological, -> { order('start_date') }
	scope :active, -> { where('status = ?', 'active') }
	scope :completed, -> { where('status = ?', 'finished') }
	scope :for_owner, -> (owner_id) { where("owner_id = ?", owner_id)}
	scope :for_category, -> (category) { where('category = ?', category) }
	scope :for_genre, -> (genre) { where('genre = ?', genre) }
	scope :for_title, -> (title) { where("title LIKE ?", title)}

	# validations
	validates_presence_of :title
	validates_presence_of :status
	validates_presence_of :genre
	validates_presence_of :category
	validates_uniqueness_of :title, :scope => :owner
	validates_inclusion_of :status, in: %w[active hiatus finished cancelled], message: "is not a valid option"
	validates_inclusion_of :preview_level, in: %w[hidden by_invitation preview published], message: "is not a valid option"
	validates_date :start_date, on_or_before:  lambda { Date.current }
    validates_date :end_date, after: :start_date, allow_blank: true

	def length
		return (self.end_date - self.start_date).to_i
	end

	def is_finished?
		return self.status == "finished" && self.end_date.nil?
	end

	def is_cancelled?
		return self.status == "cancelled" && self.end_date.nil?
	end

	def is_ended?
		if is_finished? or is_cancelled?
			self.end_date = Date.today
			self.save!
		end
	end
end
