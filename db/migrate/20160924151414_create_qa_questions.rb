class CreateQaQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_questions do |t|
      t.references :qa_game, foreign_key: true
      t.integer :state
      t.string :question

      t.timestamps
    end
  end
end
