class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :option_type
      t.string :value

      t.timestamps
    end
  end
end
