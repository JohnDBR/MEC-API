class ProductSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :description

  has_many :product_options
end
