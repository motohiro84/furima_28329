class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user,       null: false,  foreign_key: true
      t.references :product,    null: false,  foreign_key: true

      t.timestamps

      t.index [:user_id, :product_id], unique: true
    end
  end
end
