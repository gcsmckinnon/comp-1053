json.extract! qa_question, :id, :qa_game_id, :state, :question, :created_at, :updated_at
json.url qa_question_url(qa_question, format: :json)