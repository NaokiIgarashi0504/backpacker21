class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.integer :country_id,      null: false
      t.string :season,        null: false
      t.string :city,          null: false
      t.integer :English_id,       null: false
      t.integer :nice_id,         null: false
      t.integer :cleanliness_id,   null: false
      t.text :content,         null: false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
