class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.float :amount, default: 0, :precision => 8, :scale => 2
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
