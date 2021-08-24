class Article < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :country
    validates :season
    validates :city
    validates :English
    validates :nice
    validates :cleanliness
    validates :content
  end

end
