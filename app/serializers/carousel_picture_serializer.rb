class CarouselPictureSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :created_at, :updated_at
end
