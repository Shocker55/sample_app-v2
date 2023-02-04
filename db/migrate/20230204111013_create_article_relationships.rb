class CreateArticleRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :article_relationships do |t|
      t.references :article, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :article_relationships, %i[article_id tag_id], unique: true
  end
end
