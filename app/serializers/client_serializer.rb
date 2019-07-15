class ClientSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :url
end
