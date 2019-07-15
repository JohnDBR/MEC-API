class CreateProductOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :product_options do |t|
      t.string :name
      t.integer :product_id

      t.timestamps
    end
  end
end
