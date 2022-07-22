class AddCoureurToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :coureur_id, :integer
    add_column :paris, :parieur_id, :integer


  add_foreign_key :paris, :pilotes, column: :parieur_id, primary_key: :id
  add_foreign_key :paris, :pilotes, column: :coureur_id, primary_key: :id
   
 end
end
