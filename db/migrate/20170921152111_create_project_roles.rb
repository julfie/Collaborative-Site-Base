class CreateProjectRoles < ActiveRecord::Migration
  def change
    create_table :project_roles do |t|
      t.integer :project_id
      t.integer :role_id
      t.integer :user_id
      t.integer :invite_num

      t.timestamps null: false
    end
  end
end
