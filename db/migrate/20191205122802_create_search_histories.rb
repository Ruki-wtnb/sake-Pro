class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.integer :user_id
      t.string :word

      t.timestamps
    end
  end
end
