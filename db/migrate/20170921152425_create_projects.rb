class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :owner_id
      t.string :proj_description
      t.string :genre
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :category
      t.string :status
      t.string :preview_level
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
