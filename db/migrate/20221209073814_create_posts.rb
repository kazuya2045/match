class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :team_name
      t.string :personnom
      t.string :base
      t.integer :customer_id
      t.timestamps
    end
  end
end
