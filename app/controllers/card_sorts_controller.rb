class CardSortsController < ApplicationController
  before_action :set_card_sort, only: [:show, :edit, :update, :destroy]

  # GET /card_sorts
  # GET /card_sorts.json
  def index
    @card_sorts = CardSort.all
  end

  # GET /card_sorts/1
  # GET /card_sorts/1.json
  def show
  end

  # GET /card_sorts/new
  def new
    @card_sort = CardSort.new
  end

  # GET /card_sorts/1/edit
  def edit
  end

  # POST /card_sorts
  # POST /card_sorts.json
  def create
    @card_sort = CardSort.new do |csp|
      csp.name = card_sort_params['name']
      csp.description = card_sort_params['description']
      csp.code = card_sort_params['code']
      csp.author_id = card_sort_params['author_id']
      csp.cards = card_sort_params['cards'].map do |card|
        {label: card}
      end
    end

    respond_to do |format|
      if @card_sort.save
        format.html { redirect_to @card_sort, notice: 'Card sort was successfully created.' }
        format.json { render :show, status: :created, location: @card_sort }
      else
        format.html { render :new }
        format.json { render json: @card_sort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_sorts/1
  # PATCH/PUT /card_sorts/1.json
  def update
    respond_to do |format|
      if @card_sort.update(
        name: card_sort_params['name'],
        description: card_sort_params['description'],
        author_id: card_sort_params['author_id'],
        cards: card_sort_params['cards'].map{ |card| {label: card} },
      )
        format.html { redirect_to @card_sort, notice: 'Card sort was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_sort }
      else
        format.html { render :edit }
        format.json { render json: @card_sort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_sorts/1
  # DELETE /card_sorts/1.json
  def destroy
    @card_sort.destroy
    respond_to do |format|
      format.html { redirect_to card_sorts_url, notice: 'Card sort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_sort
      @card_sort = CardSort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_sort_params
      params.require( :card_sort ).permit( :name, :description, :code, :author_id, cards: [] )
    end
end
