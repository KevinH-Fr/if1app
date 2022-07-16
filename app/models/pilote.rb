class Pilote < ApplicationRecord
    belongs_to :equipe, :optional => true
    belongs_to :division, :optional => true
    has_many :resultats, :dependent => :delete_all 

    has_many :fait_paris, :class_name => 'Pari', :foreign_key => 'parieur_id'
    has_many :recu_paris, :class_name => 'Pari', :foreign_key => 'coureur_id'

    scope :statut_actif, -> { where(statut: "actif") }

   # scope :division_courante, -> { where(division_id: @divisionId)}
   #   scope :division_courante, -> (divisionId) { where('division_id ILIKE ?', "%#{item}%") }
   # scope :filter_by_division, -> (division_id) { where division_id: val }
   # scope :division_courante, ->(divisionId){ where('division_id ILIKE ?', "#{ divisionId }%")}
   #  @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId) 
   #   paginates_per 5

   #@pilotesfiltres = Pilote.filter_by_status("actif")

end
