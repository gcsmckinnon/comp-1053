class QaQuestionsController < ApplicationController
  before_action :set_qa_question, only: [:show, :edit, :update, :destroy]

  # GET /qa_questions
  # GET /qa_questions.json
  def index
    @qa_questions = QaQuestion.all
  end

  # GET /qa_questions/1
  # GET /qa_questions/1.json
  def show
  end

  # GET /qa_questions/new
  def new
    @qa_question = QaQuestion.new
  end

  # GET /qa_questions/1/edit
  def edit
  end

  # POST /qa_questions
  # POST /qa_questions.json
  def create
    @qa_question = QaQuestion.new(qa_question_params)

    respond_to do |format|
      if @qa_question.save
        format.html { redirect_to @qa_question, notice: 'Qa question was successfully created.' }
        format.json { render :show, status: :created, location: @qa_question }
      else
        format.html { render :new }
        format.json { render json: @qa_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qa_questions/1
  # PATCH/PUT /qa_questions/1.json
  def update
    respond_to do |format|
      if @qa_question.update(qa_question_params)
        format.html { redirect_to @qa_question, notice: 'Qa question was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa_question }
      else
        format.html { render :edit }
        format.json { render json: @qa_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qa_questions/1
  # DELETE /qa_questions/1.json
  def destroy
    @qa_question.destroy
    respond_to do |format|
      format.html { redirect_to qa_questions_url, notice: 'Qa question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa_question
      @qa_question = QaQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_question_params
      params.require(:qa_question).permit(:qa_game_id, :state, :question)
    end
end
