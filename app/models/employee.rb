class Employee < ApplicationRecord
    mount_uploader :picture, PictureUploader
end
