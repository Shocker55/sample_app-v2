class CreateArticleLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :article_likes do |t|
      t.integer :user_id, null: false
      t.integer :article_id, null: false

      t.timestamps

      t.index :user_id
      t.index :article_id
      t.index %i[user_id article_id], unique: true
    end
  end
end
