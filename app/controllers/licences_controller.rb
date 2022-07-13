class LicencesController < ApplicationController
  before_action :set_licence, only:[:show, :edit, :update, :destroy]

  def index
    @licences = Licence.all

    @saisons = Saison.all
    @divisions = Division.all
    @events = Event.all

    if params[:saisonId]
      @saisonId = params[:saisonId]
    end

    if params[:divisionId]
      @divisionId = params[:divisionId]

      @eventsFiltres = @events.where('saison_id = :saison_id AND division_id = :division_id',
        saison_id: @saisonId, division_id: @divisionId)
    end

    if params[:eventId]
      @eventId = params[:eventId]
      @eventNum = Event.find(@eventId).numero 

      @pilotes = Pilote.all
      @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId) 

      @licencesValDepart = 12

      @licencesEvent = Licence.all.where(event_id: @eventId)

      @licencesFiltres = Licence.joins(:event).where(
        'numero <= :numero AND 
         saison_id = :saison_id AND 
         division_id = :division_id',  
         numero: params[:numGp],
         saison_id: params[:saisonId],
         division_id: params[:divisionId]).group(:pilote_id)
          .select('pilote_id, event_id, SUM(penalite) AS total_penalite, SUM(recupere) AS total_recupere')
         
    else
      
      @pilotesActifDiv = Pilote.all
    end

  end

  def show
  end

  def new
    @licence = Licence.new
    @pilote = Pilote.all
    @event = Event.all
  end

  def edit
    @pilote = Pilote.all
    @event = Event.all
  end

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

def toggle_creerlicence
  @eventId = params[:id]
  @divisionLiee = Event.find(@eventId).division_id
  @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionLiee) 
    @pilotesActifDiv.all.each do |pilote|
      licence = Licence.create(pilote_id: pilote.id, event_id: @eventId)
    end
  
  redirect_to licences_url, notice: "la licence2 a bien été créée"
end

def toggle_supprimerlicences
  @eventId = params[:id]
  Licence.where(event_id: @eventId).destroy_all

  redirect_to licences_url, notice: "les licences de l'event courant ont bien été supprimées"
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
