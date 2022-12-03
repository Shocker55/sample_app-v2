class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
# usersテーブルのemailカラムにインデックスを追加するためにadd_index
# rails 6.29
  def change
    add_index :users, :email, unique: true
  end
end
