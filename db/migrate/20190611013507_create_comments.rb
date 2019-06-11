class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment_text
      t.integer :reply_id
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
