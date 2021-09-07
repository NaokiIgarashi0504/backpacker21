class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :reply, presence: true

end
