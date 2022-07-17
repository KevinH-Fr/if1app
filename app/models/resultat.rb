class Resultat < ApplicationRecord

    enum positions: {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 
                     6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10,
                     11 => 11, 12 => 12, 13 => 13, 14 => 14, 15 => 15,
                     16 => 16, 17 => 17, 18 => 18, 19 => 19, 20 => 20
    }

    belongs_to :pilote, :optional => true
    belongs_to :event, :optional => true
    belongs_to :saison, :optional => true

    validates :pilote_id, presence: true
    validates :ecurie, presence: true


    scope :with_mt, -> { where("(mt) = true") }

scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}

scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

scope :event_courant, -> (event_courant) { where("event_id <= ?", event_courant)}

end
