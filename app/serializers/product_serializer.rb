class ProductSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :description
end
