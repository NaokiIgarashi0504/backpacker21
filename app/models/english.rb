class English < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'Yes' },
    { id: 3, name: 'NO' },
  ]

  include ActiveHash::Associations
  has_many :articles
  
  end