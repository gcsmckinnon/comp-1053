class CardSortCandidatesController < ApplicationController
  before_action :set_card_sort_candidate, only: [:show, :edit, :update, :destroy]

  # GET /card_sort_candidates
  # GET /card_sort_candidates.json
  def index
    @card_sort_candidates = CardSortCandidate.all
  end

  # GET /card_sort_candidates/1
  # GET /card_sort_candidates/1.json
  def show
  end

  # GET /card_sort_candidates/new
  def new
    @card_sort_candidate = CardSortCandidate.new
  end

  # GET /card_sort_candidates/1/edit
  def edit
  end

  # POST /card_sort_candidates
  # POST /card_sort_candidates.json
  def create
    @card_sort_candidate = CardSortCandidate.new do |u|
      u.first_name = card_sort_candidate_params['first_name']
      u.last_name = card_sort_candidate_params['last_name']
      u.age = card_sort_candidate_params['age']
      u.describing_tags = card_sort_candidate_params['describing_tags'].split( /\r?\n/ )
    end

    respond_to do |format|
      if @card_sort_candidate.save
        format.html { redirect_to @card_sort_candidate, notice: 'Card sort candidate was successfully created.' }
        format.json { render :show, status: :created, location: @card_sort_candidate }
      else
        format.html { render :new }
        format.json { render json: @card_sort_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_sort_candidates/1
  # PATCH/PUT /card_sort_candidates/1.json
  def update
    respond_to do |format|
      if @card_sort_candidate.update(
        first_name: card_sort_candidate_params['first_name'],
        last_name: card_sort_candidate_params['last_name'],
        age: card_sort_candidate_params['age'],
        describing_tags: card_sort_candidate_params['describing_tags'].split( /\r?\n/ )
      )
        format.html { redirect_to @card_sort_candidate, notice: 'Card sort candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_sort_candidate }
      else
        format.html { render :edit }
        format.json { render json: @card_sort_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_sort_candidates/1
  # DELETE /card_sort_candidates/1.json
  def destroy
    @card_sort_candidate.destroy
    respond_to do |format|
      format.html { redirect_to card_sort_candidates_url, notice: 'Card sort candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_sort_candidate
      @card_sort_candidate = CardSortCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_sort_candidate_params
      params.require(:card_sort_candidate).permit(:first_name, :last_name, :age, :describing_tags)
    end
end
