class ClientSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :url, :created_at, :updated_at
end
