class Product < ApplicationRecord
    include AssociatedPicture

    validates :name, :description, presence: true, on: :create

    has_many :product_options, dependent: :destroy
end
