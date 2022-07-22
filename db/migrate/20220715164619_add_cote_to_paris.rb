class AddCoteToParis < ActiveRecord::Migration[7.0]
  def change
    unless column_exists? :paris, :cote
      add_column :paris, :cote, :decimal
    end
  end
end
