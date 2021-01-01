class AddGenderidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender_id, :int
  end
end
