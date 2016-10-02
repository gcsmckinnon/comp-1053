class QaGame < ApplicationRecord

  has_many :qa_options
  has_many :qa_questions

end
