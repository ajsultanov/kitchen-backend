class AddIngredientsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :ingredients, :string, array: true, default: []
  end
end
