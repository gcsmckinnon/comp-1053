class QaOption < ApplicationRecord

  belongs_to :qa_game
  has_many :qa_question_options

end
