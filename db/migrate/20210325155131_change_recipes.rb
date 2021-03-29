class ChangeRecipes < ActiveRecord::Migration[5.2]
  def change
    change_table :recipes do |t|
      t.remove :steps
      t.string :steps, array: true, default: []
    end
  end
end
