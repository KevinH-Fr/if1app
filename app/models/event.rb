class Event < ApplicationRecord
  belongs_to :saison, :optional => true

  

#  has_many :resultats, :dependent => :delete_all 

 # has_many :resultats, :dependent => :delete_all 

  

    def formatted_name
        "#{date} | #{circuit_id} | #{division}"
      end

end
