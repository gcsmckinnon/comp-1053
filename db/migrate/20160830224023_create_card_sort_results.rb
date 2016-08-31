class CreateCardSortResults < ActiveRecord::Migration[5.0]
  def change
    create_table :card_sort_results do |t|
      t.references :card_sort, foreign_key: true
      t.jsonb :result
      t.references :card_sort_candidate, foreign_key: true

      t.timestamps
    end
  end
end
