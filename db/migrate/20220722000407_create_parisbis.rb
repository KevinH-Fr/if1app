class CreateParisbis < ActiveRecord::Migration[7.0]
  def change
    create_table :parisbis do |t|

      t.timestamps
    end
  end
end
