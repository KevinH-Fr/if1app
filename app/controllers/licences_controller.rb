class LicencesController < ApplicationController
  before_action :set_licence, only: %i[ show edit update destroy ]

  # GET /licences or /licences.json
  def index
    @licences = Licence.all
  end

  # GET /licences/1 or /licences/1.json
  def show
  end

  # GET /licences/new
  def new
    @licence = Licence.new
    @pilote = Pilote.all
    @event = Event.all
  end

  # GET /licences/1/edit
  def edit
    @pilote = Pilote.all
    @event = Event.all
  end

  # POST /licences or /licences.json
  def create
    @licence = Licence.new(licence_params)

    respond_to do |format|
      if @licence.save
        format.html { redirect_to licence_url(@licence), notice: "Licence was successfully created." }
        format.json { render :show, status: :created, location: @licence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licences/1 or /licences/1.json
  def update
    respond_to do |format|
      if @licence.update(licence_params)
        format.html { redirect_to licence_url(@licence), notice: "Licence was successfully updated." }
        format.json { render :show, status: :ok, location: @licence }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licences/1 or /licences/1.json
  def destroy
    @licence.destroy

    respond_to do |format|
      format.html { redirect_to licences_url, notice: "Licence was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licence
      @licence = Licence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def licence_params
      params.require(:licence).permit(:penalite, :recupere, :pilote_id, :event_id)
    end
end
