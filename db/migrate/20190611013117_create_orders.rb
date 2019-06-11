class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :address_order
      t.datetime :date_order
      t.string :phone_order
      t.float :total_amount, default: 0, :precision => 8, :scale => 2
      t.integer :status, default: 0
      t.string :payment
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
