class Client < ApplicationRecord
    validates :name, :url, presence: true, on: :create

    mount_uploader :picture, PictureUploader
end
