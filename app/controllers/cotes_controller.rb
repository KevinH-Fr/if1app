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

      else
      end
  
      respond_to do |format|
        format.html
        format.pdf do
  
         render pdf: "CotesParis", template: "classements/liste", formats: [:html], layout: "pdf"
        end
      end
  
    end
  
    private
  
      def set_cote
        @cote = Cote.find(params[:id])
      end
  
      def cote_params
        params.fetch(:cote, {})
      end
  
  end
  