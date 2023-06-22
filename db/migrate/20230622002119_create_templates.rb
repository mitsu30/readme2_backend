class CreateTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :templates do |t|
      t.string :name, null: false
      t.string :image_path, null: false

      t.timestamps
    end
  end
end
