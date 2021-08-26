class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :country,      null: false
      t.date :season,        null: false
      t.string :city,          null: false
      t.integer :english_id,       null: false
      t.integer :nice_id,         null: false
      t.integer :safe_id,   null: false
      t.text :content,         null: false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
