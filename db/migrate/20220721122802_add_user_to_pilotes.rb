class AddUserToPilotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :pilotes, :user, null: true, foreign_key: true
  end
end
