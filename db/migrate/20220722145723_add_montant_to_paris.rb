class AddMontantToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :montant, :decimal
  end
end
