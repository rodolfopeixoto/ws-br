class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :title, default: ""
      t.integer :accommodates, default: 0
      t.integer :bathrooms, default: 0
      t.integer :number_of_rooms, default: 0
      t.boolean :furnished, default: false
      t.decimal :price, default: 0.0
      t.text :description, default: ""
      t.boolean :published, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :properties, :user_id
  end
end
