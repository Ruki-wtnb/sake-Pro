class ChangeDateAlcoholDegreeToJsakes < ActiveRecord::Migration[5.2]
  def change
    change_column :jsakes, :alcohol_degree, :string
  end
end
