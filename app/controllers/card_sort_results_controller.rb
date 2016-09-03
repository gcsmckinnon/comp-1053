class CardSortResultsController < ApplicationController
  before_action :set_card_sort_result, only: [:show, :edit, :update, :destroy]

  # GET /card_sort_results
  # GET /card_sort_results.json
  def index
    @card_sort_results = CardSortResult.all
  end

  # GET /card_sort_results/1
  # GET /card_sort_results/1.json
  def show
  end

  # GET /card_sort_results/new
  def new
    @card_sort_result = CardSortResult.new
  end

  # GET /card_sort_results/1/edit
  def edit
  end

  # POST /card_sort_results
  # POST /card_sort_results.json
  def create
    # @card_sort_result = CardSortResult.new(card_sort_result_params)

    results = JSON.parse card_sort_result_params['result']
    card_sort_id = card_sort_result_params['card_sort_id']
    card_sort_candidates = card_sort_result_params['card_sort_candidates']

    @card_sort_result = CardSortResult.new do |csr|
      csr.card_sort_id = card_sort_id
      csr.card_sort_candidates = card_sort_candidates
      csr.result = results
    end

    respond_to do |format|
      if @card_sort_result.save
        format.html { redirect_to @card_sort_result, notice: 'Card sort result was successfully created.' }
        format.json { render :show, status: :created, location: @card_sort_result }
      else
        format.html { render :new }
        format.json { render json: @card_sort_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_sort_results/1
  # PATCH/PUT /card_sort_results/1.json
  def update
    respond_to do |format|
      if @card_sort_result.update(card_sort_result_params)
        format.html { redirect_to @card_sort_result, notice: 'Card sort result was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_sort_result }
      else
        format.html { render :edit }
        format.json { render json: @card_sort_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_sort_results/1
  # DELETE /card_sort_results/1.json
  def destroy
    @card_sort_result.destroy
    respond_to do |format|
      format.html { redirect_to card_sort_results_url, notice: 'Card sort result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_sort_result
      @card_sort_result = CardSortResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_sort_result_params
      params.require( :card_sort_result ).permit( :card_sort_id, { card_sort_candidates: [] }, :result  )
    end
end
