class AddUserArticle < ActiveRecord::Migration[5.0]
  def change
    change_table :articles do |a|
      a.references :user, foreign_key: true
    end
  end
end
