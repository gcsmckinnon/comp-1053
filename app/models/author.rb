class Author < ApplicationRecord

  has_many :card_sorts

  def full_name
    "#{first_name} #{last_name}"
  end

end
