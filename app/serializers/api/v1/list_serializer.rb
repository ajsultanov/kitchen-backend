class Api::V1::ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id

  belongs_to :user
end
