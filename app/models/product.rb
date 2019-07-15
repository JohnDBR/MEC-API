class Product < ApplicationRecord
    validates :name, :description, presence: true, on: :create

    mount_uploader :picture, PictureUploader
end
