class CardSort < ApplicationRecord

  belongs_to :author
  has_many :card_sort_results

end
