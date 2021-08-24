class Exercise < ApplicationRecord
  belongs_to :user
  # validates :duration_in_min, :workout, :workout_date, presence: true
  # validates :duration_in_min, presence: true
  validates :duration_in_min, numericality: {greater_than: 0.0}
  validates :workout_date, presence: true
end
