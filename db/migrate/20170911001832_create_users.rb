class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.string :username
      t.string :password_digest
      t.boolean :active, default: true
      t.string :phone

      t.timestamps null: false
    end
  end
end
