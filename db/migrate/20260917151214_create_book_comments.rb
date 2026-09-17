class CreateBookComments < ActiveRecord::Migration[8.1]
  def change
    create_table :book_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
