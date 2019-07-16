class CarouselPicture < ApplicationRecord
    include AssociatedPicture

    belongs_to :carousel 
end
