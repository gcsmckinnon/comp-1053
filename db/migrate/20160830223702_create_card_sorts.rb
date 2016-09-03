class CreateCardSorts < ActiveRecord::Migration[5.0]
  def change
    create_table :card_sorts do |t|
      t.string :name
      t.text :description
      t.string :code
      t.jsonb :cards

      t.timestamps
    end
  end
end
