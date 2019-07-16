class ProductSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :description, :created_at, :updated_at

  has_many :product_options
end
