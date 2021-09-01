class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  as_many :replies, dependent: :destroy
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :english

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :nice

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :safe

  with_options presence: true do
    validates :images
    validates :english_id
    validates :nice_id
    validates :safe_id
    validates :content
  end

  validates :country, :city, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :season, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  
  validates :english_id, :nice_id, :safe_id, numericality: { other_than: 1, message: "can't be blank" }

  def self.search(search)
    if search != ""
      Article.where('country LIKE(?)', "%#{search}%")
    else
      Article.all
    end
  end
end
