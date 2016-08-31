class AddCardsToCardSort < ActiveRecord::Migration[5.0]
  def change
    add_column :card_sorts, :cards, :jsonb
  end
end
