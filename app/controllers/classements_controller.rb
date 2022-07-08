class ClassementsController < ApplicationController
  before_action :set_classement, only: %i[ show edit update destroy ]

  def index
    @classements = Classement.all
    @divisions = Division.all
    @events = Event.all
    @saisons = Saison.all
    @pilotes = Pilote.all
    @resultats = Resultat.all
    @resultatsFiltres = Resultat.all

    @resultat = Resultat.all

    @q = Classement.ransack(params[:q])

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

      @divisionId = Event.find(@eventId).division_id 

      @pilotes = Pilote.all
      @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId)  

        @resultatsFiltres = Resultat.joins(:event).where(
          'numero <= :numero AND 
           saison_id = :saison_id AND 
           division_id = :division_id',  
           numero: params[:numGp],
           saison_id: params[:saisonId],
           division_id: params[:divisionId])

          @resultatsFiltres = @resultatsFiltres.select(:pilote_id, "sum(score) as sum_amount").group(:pilote_id).order(
            "sum(score) desc").sum(:score)
            

    else
      
      @resultats = Resultat.all
      @resultatsFiltres = Resultat.all
      @pilotesActifDiv = Pilote.all
    end

    respond_to do |format|
      format.html
      format.pdf do

       render pdf: "classementPilotes", template: "classements/liste", formats: [:html], layout: "pdf"
      end
    end


  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_classement
      @classement = Classement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classement_params
      params.fetch(:classement, {})
    end

end
