class EmployeeSerializer < ActiveModel::Serializer
  include SerializedPicture

  attributes :id, :name, :quote
end
