class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id

  belongs_to :user
  has_many :recipes, through: :list_recipes
end
