class ParisbisController < ApplicationController
  before_action :set_parisbi, only: %i[ show edit update destroy ]

  # GET /parisbis or /parisbis.json
  def index
    @parisbis = Parisbi.all
  end

  # GET /parisbis/1 or /parisbis/1.json
  def show
  end

  # GET /parisbis/new
  def new
    @parisbi = Parisbi.new
  end

  # GET /parisbis/1/edit
  def edit
  end

  # POST /parisbis or /parisbis.json
  def create
    @parisbi = Parisbi.new(parisbi_params)

    respond_to do |format|
      if @parisbi.save
        format.html { redirect_to parisbi_url(@parisbi), notice: "Parisbi was successfully created." }
        format.json { render :show, status: :created, location: @parisbi }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parisbi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parisbis/1 or /parisbis/1.json
  def update
    respond_to do |format|
      if @parisbi.update(parisbi_params)
        format.html { redirect_to parisbi_url(@parisbi), notice: "Parisbi was successfully updated." }
        format.json { render :show, status: :ok, location: @parisbi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parisbi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parisbis/1 or /parisbis/1.json
  def destroy
    @parisbi.destroy

    respond_to do |format|
      format.html { redirect_to parisbis_url, notice: "Parisbi was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parisbi
      @parisbi = Parisbi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parisbi_params
      params.fetch(:parisbi, {})
    end
end
