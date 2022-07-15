class CreateParis < ActiveRecord::Migration[7.0]
  def change
    create_table :paris do |t|
      t.string :type
      t.integer :montant
      t.decimal :cote
      t.boolean :resultat
      t.integer :solde

      t.timestamps
    end
  end
end
