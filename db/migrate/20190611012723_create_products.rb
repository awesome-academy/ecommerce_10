class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.float :price, default: 0, :precision => 8, :scale => 2
      t.integer :rating
      t.integer :viewer
      t.integer :status, default: 0
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
