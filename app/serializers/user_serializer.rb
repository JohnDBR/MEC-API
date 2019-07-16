class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :phones, :emails, :address, :created_at, :updated_at
end
