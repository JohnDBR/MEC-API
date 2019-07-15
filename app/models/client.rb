class Client < ApplicationRecord
    mount_uploader :picture, PictureUploader
end
