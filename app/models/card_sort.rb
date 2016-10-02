class CardSort < ApplicationRecord

  acts_as_paranoid

  has_many :card_sort_results

end
