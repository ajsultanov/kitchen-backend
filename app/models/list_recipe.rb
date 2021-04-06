class ListRecipe < ApplicationRecord
    validates :list_id, uniqueness: { scope: :recipe_id}

    belongs_to :list
    belongs_to :recipe
end
