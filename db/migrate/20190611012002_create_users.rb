class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :activated, default: true
      t.integer :role, default: 1
    end
  end
end
