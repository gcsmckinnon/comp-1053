class QaGamesController < ApplicationController
  before_action :set_qa_game, only: [:show, :edit, :update, :destroy]

  # GET /qa_games
  # GET /qa_games.json
  def index
    @qa_games = QaGame.all
  end

  # GET /qa_games/1
  # GET /qa_games/1.json
  def show
  end

  # GET /qa_games/new
  def new
    @qa_game = QaGame.new
  end

  # GET /qa_games/1/edit
  def edit
  end

  # POST /qa_games
  # POST /qa_games.json
  def create
    @qa_game = QaGame.new(qa_game_params)

    respond_to do |format|
      if @qa_game.save
        format.html { redirect_to @qa_game, notice: 'Qa game was successfully created.' }
        format.json { render :show, status: :created, location: @qa_game }
      else
        format.html { render :new }
        format.json { render json: @qa_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qa_games/1
  # PATCH/PUT /qa_games/1.json
  def update
    respond_to do |format|
      if @qa_game.update(qa_game_params)
        format.html { redirect_to @qa_game, notice: 'Qa game was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa_game }
      else
        format.html { render :edit }
        format.json { render json: @qa_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qa_games/1
  # DELETE /qa_games/1.json
  def destroy
    @qa_game.destroy
    respond_to do |format|
      format.html { redirect_to qa_games_url, notice: 'Qa game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # game related CRUD
  def set_game_board
    respond_to do |format|
      format.html
      format.json do
        QaQuestion.reset_questions params["game_id"]
        question = QaQuestion.get_new_question
        render json: question.to_json
      end
    end
  end

  def get_new_question
    respond_to do |format|
      format.html
      format.json do
        question = QaQuestion.get_new_question
        render json: question.to_json
      end
    end
  end

  def get_current_question
    respond_to do |format|
      format.html
      format.json do
        question = QaQuestion.get_current_question
        render json: question.to_json
      end
    end
  end

  def get_current_question_id
    respond_to do |format|
      format.html
      format.json do
        question = QaQuestion.get_current_question
        if question
          render json: { questionID: question.id}
        else
          render json: false.to_json
        end
      end
    end
  end

  def record_answer
    respond_to do |format|
      format.html
      format.json do
        question = QaQuestion.find(params["questionID"])
        while question.get_state == :waiting
          question.set_busy
          option = QaQuestionOption.where( qa_option_id: params["optionID"] ).first_or_initialize do |o|
            o.qa_question_id = question.id
            o.value = 0
          end
          option.increment( :value )
          option.save
        end
        question.set_waiting
        render json: question.to_json
      end
    end
  end

  # controller private
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa_game
      @qa_game = QaGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_game_params
      params.require(:qa_game).permit(:name, :layout)
    end
end
