class Task < ApplicationRecord
    # Relationships
    has_many :chores
    has_many :children, through: :chores

    # Validations
    validates :name, presence: true
    validates :points,
                numericality: { only_integer: true, greater_than: 0 }

    # Scopes
    scope :alphabetical, -> { order(:name) }
    scope :active, -> { where(active: true) }
end
