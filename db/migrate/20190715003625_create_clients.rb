class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :url
      t.string :picture

      t.timestamps
    end
  end
end
