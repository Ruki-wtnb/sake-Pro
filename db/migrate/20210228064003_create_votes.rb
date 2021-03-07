class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :jsake_id
      t.integer :user_id
      t.integer :taste_id

      t.timestamps
    end
  end
end
