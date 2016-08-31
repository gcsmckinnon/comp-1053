class CreateCardSortCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :card_sort_candidates do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.jsonb :describing_tags

      t.timestamps
    end
  end
end
