class ParisTypeChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :paris, :typepari, :integer
  end
end
