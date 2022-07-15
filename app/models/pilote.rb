class Pilote < ApplicationRecord
    belongs_to :equipe, :optional => true
    belongs_to :division, :optional => true
    has_many :resultats, :dependent => :delete_all 

    has_many :fait_paris, :class_name => 'Pari', :foreign_key => 'parieur_id'
    has_many :recu_paris, :class_name => 'Pari', :foreign_key => 'coureur_id'
  

 #   paginates_per 5

end
