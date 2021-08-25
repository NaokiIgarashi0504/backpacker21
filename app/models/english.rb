class English < ActiveHash::Base
  self.data = [
    { id: 1, name: 'able to communicate in English' },
    { id: 2, name: 'Yes' },
    { id: 3, name: 'NO' },
  ]

  include ActiveHash::Associations
  has_many :articles
  
  end