class Api::V1::ListRecipeSerializer < ActiveModel::Serializer
  attributes :id, :list_id, :recipe_id
end
