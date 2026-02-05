class Chore < ApplicationRecord
  # Relationships
  belongs_to :child
  belongs_to :task

  # Validations
  validates :due_on, presence: true
  validate :due_on_is_a_date

  # Scopes
  scope :by_task, -> { joins(:task).order('tasks.name') }
  scope :chronological, -> { order(:due_on) }
  scope :pending, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }
  scope :upcoming, -> { where('due_on >= ?', Date.today) }
  scope :past, -> { where('due_on < ?', Date.today) }

  # Instance methods
  def status
    completed ? "Completed" : "Pending"
  end

  private

  def due_on_is_a_date
    errors.add(:due_on, "must be a valid date") unless due_on.is_a?(Date)
  end
end
