class Comment < ApplicationRecord
  belongs_to :gossip
  belongs_to :user

  validates :content, presence: true
  validates :user, presence: true # Ajoutez cette ligne
end
