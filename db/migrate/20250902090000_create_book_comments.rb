class CreateBookComments < ActiveRecord::Migration[6.0]
  def change
    create_table :book_comments do |t|
      t.text    :comment, null: false
      t.integer :user_id, null: false
      t.integer :book_id, null: false

      t.timestamps
    end

    add_index :book_comments, :user_id
    add_index :book_comments, :book_id
  end
end

