class Product < ApplicationRecord
    include AssociatedPicture

    validates :name, :description, presence: true, on: :create
end
