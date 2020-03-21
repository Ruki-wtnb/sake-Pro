class AddAmakaraToJsakes < ActiveRecord::Migration[5.2]
  def change
    add_column :jsakes, :amakara, :string
  end
end
