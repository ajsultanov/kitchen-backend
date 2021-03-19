class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :author, :steps, :cook_time, :servings
end
