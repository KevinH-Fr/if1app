class PariquartsController < ApplicationController
  before_action :set_pariquart, only: %i[ show edit update destroy ]

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

  #    @pariquarts = Pariquart.event_courant(@eventId).all
  @pariquarts = Pariquart.all

      @coureur = Pilote.statut_actif.division_courant(@divisionId).all
      @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

      
    respond_to do |format|
      format.html
      format.pdf do

       render pdf: "resultats", template: "paris/liste", formats: [:html], layout: "pdf"
      end
    end


    else
      
    end

  end

  def show
    
  end

  def new

    @pariquart =  Pariquart.new(pariquart_params)

    @divisionId = params[:divisionId]
    @eventId = params[:eventId]
    @pariquart = Pariquart.new(pariquart_params)

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
    @pariquart = Pariquart.new(pariquart_params)
    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
   # @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    @event = Event.all
    @pilote = Pilote.all

    respond_to do |format|
      if @pariquart.save
        format.html { redirect_to pariquart_url(@pariquart), notice: "Pari was successfully created." }
        format.json { render :show, status: :created, location: @pari }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pariquart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pariquart.update(pariquart_params)
        format.html { redirect_to pariquart_url(@pariquart), notice: "Pari was successfully updated." }
        format.json { render :show, status: :ok, location: @pariquart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pariquart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pariquart.destroy

    respond_to do |format|
      format.html { redirect_to pariquarts_url, notice: "Pari was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_calculresultats

    @eventId = params[:id]
    @divisionId = Event.find(@eventId).division_id
    @saisonId = Event.find(@eventId).saison_id

    @parisEvent = Pariquart.event_courant(@eventId)

    @parisEvent.all.each do |pari|

      coureurId = pari.coureur_id
      typePari = pari.typepari
      resultatCoureur = Resultat.where(event_id: @eventId, pilote_id: coureurId).first.course

      pariMontant = pari.montant
      pariCote = pari.cote

      if typePari == "victoire" && resultatCoureur == 1 || typePari == "podium" && resultatCoureur <= 3 || typePari == "top10" && resultatCoureur <= 10

          pari.update(resultat: true)
          pari.update(solde: pariMontant * pariCote - pariMontant )
        else
          pari.update(resultat: false)
          pari.update(solde: - pariMontant )
        end

    end  
    
    redirect_to pariquarts_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
               notice: "les r??sultats des paris de l'event courant ont bien ??t?? mis ?? jour"

  end


  private
    def set_pariquart
      @pariquart = Pariquart.find(params[:id])
    end

    def pariquart_params
      
      params.fetch(:pariquart, {}).permit(:montant, :cote, :resultat, :solde, :event_id, :parieur_id, :coureur_id, :typepari)
    end
end
