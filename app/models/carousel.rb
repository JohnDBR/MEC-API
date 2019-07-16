class Carousel < ApplicationRecord
    validates :name, presence: true, on: :create

    has_many :carousel_pictures, dependent: :destroy
end
