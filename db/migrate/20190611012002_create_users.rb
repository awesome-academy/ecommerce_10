class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.integer :role, default: 1

      t.timestamps
    end
  end
end
