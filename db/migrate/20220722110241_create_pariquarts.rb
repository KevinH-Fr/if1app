class CreatePariquarts < ActiveRecord::Migration[7.0]
  def change
    create_table :pariquarts do |t|
      t.integer :typepari
      t.references :parieur, null: false, foreign_key: true
      t.references :coureur, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.decimal :solde
      t.decimal :cote
      t.boolean :resultat
      t.integer :montant

      t.timestamps
    end
  end
end
