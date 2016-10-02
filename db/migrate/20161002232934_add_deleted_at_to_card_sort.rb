class AddDeletedAtToCardSort < ActiveRecord::Migration[5.0]
  def change
    add_column :card_sorts, :deleted_at, :datetime
    add_index :card_sorts, :deleted_at
  end
end
