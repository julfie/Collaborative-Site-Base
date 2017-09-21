class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :owner_id
      t.string :title
      t.integer :user_id
      # t.integer :content_id
      # t.integer :project_role_id
      t.string :category
      t.string :genre
      t.string :preview_level, default: "hidden"
      t.string :status, default: "active"
      t.date :start_date
      t.date :end_date

#      t.timestamps null: false
    end
  end
end
