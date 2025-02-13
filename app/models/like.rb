class Like < ApplicationRecord
  belongs_to :gossip
  belongs_to :user
  validates :user_id, uniqueness: { scope: :gossip_id }
end
