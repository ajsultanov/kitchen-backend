class CreateApiV1Lists < ActiveRecord::Migration[5.2]
  def change
    create_table :api_v1_lists do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
