class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, index: {unique: true}
      t.string :description
      t.integer :price_cents

      t.timestamps
    end
  end
end
