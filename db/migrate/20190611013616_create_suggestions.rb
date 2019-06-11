class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.text :message
      t.references :suggestion, foreign_key: true
      t.timestamps
    end
  end
end
