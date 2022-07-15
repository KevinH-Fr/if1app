class ParisController < ApplicationController
  before_action :set_pari, only: %i[ show edit update destroy ]

  # GET /paris or /paris.json
  def index
    @paris = Pari.all

  end

  # GET /paris/1 or /paris/1.json
  def show
  end

  # GET /paris/new
  def new
    @pari = Pari.new
    @pilote = Pilote.all
    @event = Event.all
  end

  # GET /paris/1/edit
  def edit
  end

  # POST /paris or /paris.json
  def create
    @pari = Pari.new(pari_params)

    respond_to do |format|
      if @pari.save
        format.html { redirect_to pari_url(@pari), notice: "Pari was successfully created." }
        format.json { render :show, status: :created, location: @pari }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paris/1 or /paris/1.json
  def update
    respond_to do |format|
      if @pari.update(pari_params)
        format.html { redirect_to pari_url(@pari), notice: "Pari was successfully updated." }
        format.json { render :show, status: :ok, location: @pari }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paris/1 or /paris/1.json
  def destroy
    @pari.destroy

    respond_to do |format|
      format.html { redirect_to paris_url, notice: "Pari was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pari
      @pari = Pari.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pari_params
      params.require(:pari).permit(:type, :montant, :cote, :resultat, :solde, :event_id, :pilote_id)
    end
end
