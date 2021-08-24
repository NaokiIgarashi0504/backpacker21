class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.integer :country,      null: false
      t.string :season,        null: false
      t.string :city,          null: false
      t.integer :English,       null: false
      t.integer :nice,         null: false
      t.integer :cleanliness,   null: false
      t.text :content,         null: false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
