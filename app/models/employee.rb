class Employee < ApplicationRecord
    validates :name, :quote, presence: true, on: :create

    mount_uploader :picture, PictureUploader
end
