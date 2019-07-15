class Client < ApplicationRecord
    include AssociatedPicture

    validates :name, :url, presence: true, on: :create
end
