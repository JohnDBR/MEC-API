class CreateCarouselPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :carousel_pictures do |t|
      t.string :picture
      t.integer :carousel_id

      t.timestamps
    end
  end
end
