class CotesController < ApplicationController
    before_action :set_cote, only: %i[ show edit update destroy ]
  
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
  
       # @divisionId = Event.find(@eventId).division_id 
  
      #  @resultats = Resultat.all

      # @resultats_division = Resultat.division_courant(@divisionId).all
     
      # @resultats_saison = Resultat.saison_courant(@saisonId).all

       #@resultats_until_numero_event = Resultat.numero_until_courant(@eventNum).all

        @resultats_filtres = Resultat.saison_courant(@saisonId)
                                          .division_courant(@divisionId)
                                          .numero_until_courant(@eventNum).all




      #  @resultats = Resultat.event_courant(@eventId).all

      #  @pilotes = Pilote.all
      #  @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId)  
  
       #   @resultatsFiltres = Resultat.joins(:event).where(
       #     'numero <= :numero AND 
       #      saison_id = :saison_id AND 
       #      division_id = :division_id',  
       #      numero: params[:numGp],
       #      saison_id: params[:saisonId],
       #      division_id: params[:divisionId])
  



     # @pilotes = @pilotes.filter_by_division(params[:divisionId]) if params[:divisionId].present?
   #   @pilotes = Pilote.statut_actif.division_courant(@divisionId).all
            
      else
        
        @resultats = Resultat.all
    #    @resultatsFiltres = Resultat.all
    #    @pilotesActifDiv = Pilote.all
      end
  
      respond_to do |format|
        format.html
        format.pdf do
  
         render pdf: "CotesParis", template: "classements/liste", formats: [:html], layout: "pdf"
        end
      end
  
  
    end
  
    private
  
      # Use callbacks to share common setup or constraints between actions.
      def set_cote
        @cote = Cote.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def cote_params
        params.fetch(:cote, {})
      end
  
  end
  