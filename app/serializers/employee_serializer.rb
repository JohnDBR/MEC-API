class EmployeeSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :quote, :created_at, :updated_at
end
