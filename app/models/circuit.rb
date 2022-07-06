class Circuit < ApplicationRecord
    has_one_attached :drapeau
    has_one_attached :carte

end
