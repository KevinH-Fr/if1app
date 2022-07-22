class CreateParister < ActiveRecord::Migration[7.0]
  def change
    create_table :paristers do |t|
      t.decimal :montant

      t.timestamps
    end
  end
end
