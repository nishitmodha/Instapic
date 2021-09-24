class AddIndexForConversation < ActiveRecord::Migration[6.0]
  def change
    add_index :conversations, [:author_id, :receiver_id], unique: true
  end
end
