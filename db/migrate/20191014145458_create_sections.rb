class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :description
      t.text :content
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
