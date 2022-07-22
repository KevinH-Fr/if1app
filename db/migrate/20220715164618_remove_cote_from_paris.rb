class RemoveCoteFromParis < ActiveRecord::Migration[7.0]
  def change
    remove_column :paris, :cote, :decimal
  end
end
