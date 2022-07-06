class Circuit < ApplicationRecord
    has_one_attached :drapeau
    has_one_attached :carte

    belongs_to :event, :optional => true
end
