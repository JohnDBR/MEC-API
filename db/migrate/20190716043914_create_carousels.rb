class CreateCarousels < ActiveRecord::Migration[5.2]
  def change
    create_table :carousels do |t|
      t.string :name

      t.timestamps
    end
  end
end
