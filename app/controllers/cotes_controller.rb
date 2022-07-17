class CotesController < ApplicationController
  before_action :set_cote, only: %i[ show edit update destroy ]
  
    def index
     
      @divisions = Division.all
      @events = Event.all
      @saisons = Saison.all
     
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

        @resultats_filtres = Resultat.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum)
                                     .group_sum_order
        
        @testmaxScore = @resultats_filtres.pluck(:pilote_id, :total).first 

        @calculs_cotes = Resultat.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum)
        .group_sum_order

      #  @calculs_cotes = @resultats_filtres.pluck(:pilote_id, :total) 

       # @valDepuisModel = Resultat.valeur 
     #   @resultatsFiltres = @resultatsFiltres.select(:pilote_id, "sum(score) as sum_amount").group(:pilote_id).order(
      #    "sum(score) desc").sum(:score)

      else
      end
  
      respond_to do |format|
        format.html
        format.pdf do
         render pdf: "CotesParis", template: "classements/liste", formats: [:html], layout: "pdf"
        end
      end
  
    end

    def toggle_calculcotes
        
      @eventId = params[:id]
      @licencesValDepart = 12
      @divisionLiee = Event.find(@eventId).division_id
      @saisonLiee = Event.find(@eventId).saison_id
      @licencesEvent = Licence.all.where(event_id: @eventId)
    
      @numEvent = Event.find(@eventId).numero
   
      @resultats_filtres = Resultat.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum)
      .group_sum_order

        @resultats_filtres.each do |resultat|

          piloteId = resultat.pilote_id
    
          resultat = Resultat.where(event_id: @eventId, pilote_id: piloteId)
          resultat.update(cote: 100)
         
        end
    
        redirect_to cotes_url(numGp: @numEvent, saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionLiee), 
                      notice: "les points ont bien été calculés"
    end

  
    private
  
      def set_cote
        @cote = Cote.find(params[:id])
      end
  
      def cote_params
        params.fetch(:cote, {})
      end
  
  end
  