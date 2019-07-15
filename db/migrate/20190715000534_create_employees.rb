class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :quote
      t.string :picture

      t.timestamps
    end
  end
end
