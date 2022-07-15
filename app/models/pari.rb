class Pari < ApplicationRecord
    belongs_to :parieur, :class_name => 'Pilote', :optional => true
    belongs_to :coureur, :class_name => 'Pilote', :optional => true
end
