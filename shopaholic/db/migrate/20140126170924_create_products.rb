class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.references :category, index: true
      t.timestamps
    end
  end
end
