class SectionSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :description, :created_at, :updated_at
end
