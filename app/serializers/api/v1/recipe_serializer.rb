class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :author, :steps, :cook_time, :servings, :url, :ingredients

  has_many :lists, through: :list_recipes
end
