class Message < ActiveRecord::Base
	# relationships
	belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
	belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

	# scopes
	scope :chronological, -> { order('send_date') }
	scope :by_username, -> { joins(:sender).order('users.username') }
	scope :by_subject, -> { order('subject') }
	scope :isread, -> { where(read_status: true) }
	scope :unread, -> { where(read_status: false) }
	scope :flagged, -> { where(flagged: true) }
	scope :for_username, -> (username) { joins(:sender).where('users.username LIKE ?', username) }
	scope :for_keyword, -> (keyword) { where('subject LIKE lower(?) OR body LIKE lower(?)', "#{keyword.downcase}%", "#{keyword.downcase}%") }

	# validations
	validates_presence_of :subject
	validates_presence_of :body
	validates_inclusion_of :read_status, in: [true,false]
end
