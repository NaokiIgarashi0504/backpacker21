class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :english

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :nice

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :safe

  with_options presence: true do
    validates :english_id
    validates :nice_id
    validates :safe_id
    validates :content
  end

  validates :country, :city, :season, presence: true, format: { with: /^[a-zA-Z0-9]+$/ }

  validates :english_id, :nice_id, :safe_id, numericality: { other_than: 1, message: "can't be blank" }
end
