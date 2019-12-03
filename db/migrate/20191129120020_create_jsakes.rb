class CreateJsakes < ActiveRecord::Migration[5.2]
  def change
    create_table :jsakes do |t|
      
      t.integer :user_id
      t.string :image_url
      t.string :meigara
      t.string :seimai_buai
      t.string :locaility
      t.string :alcohol_degree
      t.float :sake_meter_value
      t.float :acidity
      
      t.timestamps
    end
  end
end
