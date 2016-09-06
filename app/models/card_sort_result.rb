class CardSortResult < ApplicationRecord

  belongs_to :card_sort

  def pretty
    dom = walkit
    return dom.flatten.compact.join("").html_safe
  end

  def walkit item = false, tree = false
    item = item || result
    tree = tree || []

    tree << "<ul>"
    item.each do |key, value|
      if value.kind_of?(Hash)
        tree << "<li>"
        tree << key
        walkit value, tree
      elsif value.kind_of?(Array)
        value.compact.each{ |v| tree << "<li>#{v}</li>" }
      end
      tree << "</li>"
    end

    tree << "</ul>"

    return tree
  end

end
