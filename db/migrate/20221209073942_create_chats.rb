class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :message
      t.integer :customer_id
      t.integer :room_id
      t.timestamps
    end
  end
end
