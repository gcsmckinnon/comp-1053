class QaQuestion < ApplicationRecord

  belongs_to :qa_game
  has_many :qa_question_options

  enum state: [:ready, :waiting, :busy, :done, :closed]

  def self.get_new_question
    # find current question if there is one
    if current = self.where(state: :waiting).last
      current.set_closed
      current.save
    end

    # deliver new question
    if current = self.where(state: :ready).first
      current.set_waiting
      return current
    else
      return false
    end
  end

  def self.get_current_question
    if current = self.where(state: :waiting).first
      return current
    else
      return false
    end
  end

  def self.reset_questions gameID
    question_set = self.where( qa_game_id: gameID )
    question_set.each{ |qs| qs.qa_question_options.update( value: 0 ) }
    question_set.update( state: :ready )
  end

  def set_ready
    self.state = :ready
    self.save
  end

  def set_waiting
    self.state = :waiting
    self.save
  end

  def set_busy
    self.state = :busy
    self.save
  end

  def set_done
    self.state = :done
    self.save
  end

  def set_closed
    self.state = :closed
    self.save
  end

  def get_state
    case self.state
      when "ready"
        return :ready
      when "waiting"
        return :waiting
      when "busy"
        return :busy
      when "done"
        return :done
      when "closed"
        return :closed
      else
        return false
    end
  end

end
