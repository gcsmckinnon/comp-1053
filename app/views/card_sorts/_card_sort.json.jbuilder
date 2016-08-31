json.extract! card_sort, :id, :name, :description, :code, :created_at, :updated_at
json.url card_sort_url(card_sort, format: :json)