class Pari < ApplicationRecord
    belongs_to :parieur, :class_name => 'Pilote', :optional => true
    belongs_to :coureur, :class_name => 'Pilote', :optional => true

    enum typepari: [:victoire, :podium, :top10]
    #TYPES_PARI = ["victoire", "podium"]

   # scope :typevictoire, -> { where(typepari: 'victoire')}

    scope :event_courant, -> (event_courant) { where(event_id: event_courant)}


end
