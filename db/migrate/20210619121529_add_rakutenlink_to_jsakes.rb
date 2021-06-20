class AddRakutenlinkToJsakes < ActiveRecord::Migration[5.2]
  def change
    add_column :jsakes, :rakutenlink, :text
  end
end
