class ProjectRole < ActiveRecord::Base

    # Relationships
    # -----------------------------
    belongs_to :user
    belongs_to :role
    belongs_to :project    

    # scopes
    # -----------------------------
    scope: by_user,     -> { order("user") }
    scope: by_role,     -> { order("role") }
    scope: by_project,  -> { order("user") }
    scope: filled,      -> { where("user iS NOT NULL") }
    scope: empty,       -> { where("user iS NULL") }

    # Validations
    # -----------------------------
    validates_presence_of :role
    validates_presence_of :invite_num
    validates_numericality_of :invite_num, greater_than_or_equal_to: 0

    # Callbacks
    # -----------------------------
    before_destroy :is_destroyable?

    # Additional Methods
    # -----------------------------
    def is_destroyable?
        return self.user.nil?
    end
    
end
