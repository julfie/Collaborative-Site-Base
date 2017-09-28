class ProjectRole < ActiveRecord::Base
	 # Relationships
    # -----------------------------
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    belongs_to :role, class_name: "Role", foreign_key: "role_id"
    belongs_to :project, class_name: "Project", foreign_key: "project_id"

    # scopes
   # -----------------------------
   scope :by_user,     -> { joins(:user).order('users.l_name').order('users.f_name') }
   scope :by_role,     -> { joins(:role).order('roles.name') }
   scope :by_project,  -> { joins(:project).order('projects.title') }
   scope :filled,      -> { where("user_id iS NOT NULL") }
   scope :empty,       -> { where("user_id iS NULL") }

    # Validations
    # -----------------------------
    validates_presence_of :role_id
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
