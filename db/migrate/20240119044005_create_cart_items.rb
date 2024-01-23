class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :user, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
