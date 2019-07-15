class ProductOption < ApplicationRecord
    validates :name, presence: true, on: :create

    belongs_to :product
end
