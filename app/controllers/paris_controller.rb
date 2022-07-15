class ParisController < ApplicationController
  before_action :set_pari, only: %i[ show edit update destroy ]

  def index
    @paris = Pari.all

  end

  def show
  end

  def new
    @pari = Pari.new
    @pilote = Pilote.all
    @event = Event.all


  end

  def edit
    @pilote = Pilote.all
    @event = Event.all
  end

  def create
    @pari = Pari.new(pari_params)

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
      params.require(:pari).permit(:typepari, :montant, :cote, :resultat, :solde, :event_id, :parieur_id, :coureur_id)
    end
end
