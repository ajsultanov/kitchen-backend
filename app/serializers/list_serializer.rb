class Api::V1::ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
