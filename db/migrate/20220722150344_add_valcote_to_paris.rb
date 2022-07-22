class AddValcoteToParis < ActiveRecord::Migration[7.0]
  def change
    add_column :paris, :valcote, :decimal
  end
end
