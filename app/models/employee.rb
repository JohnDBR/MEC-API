class Employee < ApplicationRecord
    include AssociatedPicture

    validates :name, :quote, presence: true, on: :create
end
