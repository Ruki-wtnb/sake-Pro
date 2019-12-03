class CreateSeimaibuais < ActiveRecord::Migration[5.2]
  def change
    create_table :seimaibuais do |t|
      
      t.string :name

      t.timestamps
    end
  end
end
