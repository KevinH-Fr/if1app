class AddEventToParisbis < ActiveRecord::Migration[7.0]
  def change
    add_reference :parisbis, :event, null: false, foreign_key: true
  end
end
