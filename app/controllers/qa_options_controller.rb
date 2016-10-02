class QaOptionsController < ApplicationController
  before_action :set_qa_option, only: [:show, :edit, :update, :destroy]

  # GET /qa_options
  # GET /qa_options.json
  def index
    @qa_options = QaOption.all
  end

  # GET /qa_options/1
  # GET /qa_options/1.json
  def show
  end

  # GET /qa_options/new
  def new
    @qa_option = QaOption.new
  end

  # GET /qa_options/1/edit
  def edit
  end

  # POST /qa_options
  # POST /qa_options.json
  def create
    @qa_option = QaOption.new(qa_option_params)

    respond_to do |format|
      if @qa_option.save
        format.html { redirect_to @qa_option, notice: 'Qa option was successfully created.' }
        format.json { render :show, status: :created, location: @qa_option }
      else
        format.html { render :new }
        format.json { render json: @qa_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qa_options/1
  # PATCH/PUT /qa_options/1.json
  def update
    respond_to do |format|
      if @qa_option.update(qa_option_params)
        format.html { redirect_to @qa_option, notice: 'Qa option was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa_option }
      else
        format.html { render :edit }
        format.json { render json: @qa_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qa_options/1
  # DELETE /qa_options/1.json
  def destroy
    @qa_option.destroy
    respond_to do |format|
      format.html { redirect_to qa_options_url, notice: 'Qa option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa_option
      @qa_option = QaOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_option_params
      params.require(:qa_option).permit(:qa_game_id, :option)
    end
end
