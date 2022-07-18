class ParisController < ApplicationController
  before_action :set_pari, only: %i[ show edit update destroy ]

  def index

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

      @paris = Pari.event_courant(@eventId).all

      @coureur = Pilote.statut_actif.division_courant(@divisionId).all
      @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    else
      
    end

  end

  def show
    
  end

  def new
    @divisionId = params[:divisionId]
    @eventId = params[:eventId]

    @pari = Pari.new(pari_params)

    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    @event = Event.all

  end

  def edit
    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all
    
    @event = Event.all
  end

  def create
    @pari = Pari.new(pari_params)
    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    @event = Event.all
    @pilote = Pilote.all

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

  def destroy
    @pari.destroy

    respond_to do |format|
      format.html { redirect_to paris_url, notice: "Pari was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_pari
      @pari = Pari.find(params[:id])
    end

    def pari_params
      
      params.fetch(:pari, {}).permit(:montant, :cote, :resultat, :solde, :event_id, :parieur_id, :coureur_id, :typepari)
    end
end
