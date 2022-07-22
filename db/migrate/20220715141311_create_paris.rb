class CreateParis < ActiveRecord::Migration[7.0]
  def change
    create_table :paris do |t|
      t.string :type
      t.integer :montant
    #  t.decimal :cote
      t.boolean :resultat
      t.integer :solde

      t.references :parieur
      t.references :coureur

      t.timestamps
    end

    add_foreign_key :paris, :pilotes, column: :parieur_id, primary_key: :id
    add_foreign_key :paris, :pilotes, column: :coureur_id, primary_key: :id

  end
end
