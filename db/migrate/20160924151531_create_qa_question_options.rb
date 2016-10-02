class CreateQaQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_question_options do |t|
      t.references :qa_question, foreign_key: true
      t.references :qa_option, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
