class Article < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :country, :english, :nice, :cleanliness

  with_options presence: true do
    validates :country
    validates :season
    validates :city
    validates :English
    validates :nice
    validates :cleanliness
    validates :content
  end

  validates :country_id, :english_id, numericality: { other_than: 1, message: "can't be blank" }
end
