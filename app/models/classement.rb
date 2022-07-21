class Classement < ApplicationRecord
  #  has_many :events, through: :resultats
  belongs_to :event, :optional => true
  #before_validation :toggle_creerclassements
  #include Sluggable;

 # has_many :resultats, :dependent => :delete_all 

 scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}
 
 scope :saison_courant, -> (saison_courant) { joins(:event).where("saison_id = ?", saison_courant)}
 scope :division_courant, -> (division_courant) { joins(:event).where("division_id = ?", division_courant)}
 scope :numero_until_courant, -> (numero_until_courant) { joins(:event).where("numero <= ?", numero_until_courant)}

 scope :order_by_score, -> { order('score').reverse }

 # test scopes p1, p2 etc pour ranking
scope :compte_p1, -> { where("(course) = 1").count}
scope :compte_p2, -> { where("(course) = 2").count}
scope :compte_p3, -> { where("(course) = 3").count}
scope :compte_p4, -> { where("(course) = 4").count}
scope :compte_p5, -> { where("(course) = 5").count}

# continuer ajouter les autres compte p x


scope :order_score_positions, -> {order(score: :DESC, compte_p1: :DESC) }

# continuer ajouter les autres compte p x


 scope :max_points, -> { all.order(score: :DESC).first }






end