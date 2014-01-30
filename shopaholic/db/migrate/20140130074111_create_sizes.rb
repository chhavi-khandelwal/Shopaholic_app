class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :name
      t.decimal :price, precision:10, scale: 2
      t.decimal :discounted_price, precision:10, scale:2
      t.integer :quantity
      t.timestamps
    end
  end
end
