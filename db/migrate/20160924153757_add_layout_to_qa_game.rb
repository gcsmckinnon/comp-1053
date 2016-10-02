class AddLayoutToQaGame < ActiveRecord::Migration[5.0]
  def change
    add_column :qa_games, :layout, :string
  end
end
