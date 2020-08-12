class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :image,            null: false
      t.string :title,          null: false
      t.text :text,             null: false
      t.integer :price,         null: false
      t.references :user,       null: false,  foreign_key: true
      t.integer :category_id,   null: false
      t.integer :condition,     null: false
      t.integer :postage,       null: false
      t.integer :prefecture_id, null: false
      t.integer :shipment,      null: false
      t.timestamps
    end
  end
end
