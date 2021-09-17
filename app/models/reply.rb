class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  has_one :article, through: :comment

  validates :reply, presence: true

end
