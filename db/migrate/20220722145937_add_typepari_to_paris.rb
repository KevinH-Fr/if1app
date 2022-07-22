class AddTypepariToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :typepari, :integer
  end
end
