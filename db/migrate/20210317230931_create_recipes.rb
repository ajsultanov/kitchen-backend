class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :author
      t.text :steps
      t.integer :cook_time
      t.integer :servings

      t.timestamps
    end
  end
end
