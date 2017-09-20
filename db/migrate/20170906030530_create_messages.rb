class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :body
      t.string :invite_code
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :read_status, default: false
      t.date :send_date
      t.boolean :flagged, default: false
      t.integer :user_id

#      t.timestamps null: false
    end
  end
end
