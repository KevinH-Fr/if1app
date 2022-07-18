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

    #  @pilotes = Pilote.all
    #  @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId)  

     #   @resultatsFiltres = Resultat.joins(:event).where(
     #     'numero <= :numero AND 
     #      saison_id = :saison_id AND 
     #      division_id = :division_id',  
     #      numero: params[:numGp],
     #      saison_id: params[:saisonId],
     #      division_id: params[:divisionId])

    #      @resultatsFiltres = @resultatsFiltres.select(:pilote_id, "sum(score) as sum_amount").group(:pilote_id).order(
    #        "sum(score) desc").sum(:score)

        
     #   @classements = Resultat.saison_courant(@saisonId)
     #   .division_courant(@divisionId)
     #   .numero_until_courant(@eventNum).group_sum_order
    
     @classements = Classement.event_courant(@eventId)

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

def show
end

def destroy

  @classement.destroy

  respond_to do |format|
    format.html { redirect_to classements_url, notice: "classement was successfully destroyed." }
    format.json { head :no_content }
  end
end

def toggle_creerclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonLiee = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  @pilotes = Pilote.statut_actif.division_courant(@divisionId).all
    @pilotes.all.each do |pilote|
      classement = Classement.create(pilote_id: pilote.id, event_id: @eventId)
    end
  
  redirect_to classements_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été créés"
end

def toggle_supprimerclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id

  Classement.where(event_id: @eventId).destroy_all

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
               notice: "les classements de l'event courant ont bien été supprimés"
end


def toggle_updateclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  max_points = Classement.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@numGp).max_points.score.to_i

  @classementsEvent = Classement.all.where(event_id: @eventId)

    @classementsEvent.each_with_index do |classement, i|

      i = i + 1

      @piloteId = classement.pilote_id

      # obtenir le score total du pilote, ajouter les filtres les uns apres les autres
      valScore = Resultat.pilote_courant(@piloteId).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).sum(:score)
      valCoteBase = 1 + ((max_points - valScore)/100)


      classement.update(score: valScore )
      classement.update(cote:  valCoteBase)

    end

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été mis à jour"
end


def toggle_triclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  @classementsEvent = Classement.all.where(event_id: @eventId).order(:score).reverse

    @classementsEvent.each_with_index do |classement, i|

      i = i + 1
      valPosition = i 
      valScore = classement.score
      valCoteBase = classement.cote
      valCoteVictoire = valCoteBase * (1 * valPosition)

      classement.update(position:  valPosition)


    end

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été triés"
end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_classement
      @classement = Classement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classement_params
     # params.fetch(:classement, {})
     params.require(:classement).permit(:cote, :pilote_id, :event_id)
    end


end
