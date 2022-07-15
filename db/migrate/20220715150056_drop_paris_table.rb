class DropParisTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :paris
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
