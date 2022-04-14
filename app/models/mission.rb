class Mission < ApplicationRecord
  belongs_to :scientist
  belongs_to :planet

  validates :name, :scientist_id, :planet_id, presence: true
  validates :scientist, uniqueness: { scope: :name }
end
