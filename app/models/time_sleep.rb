# frozen_string_literal: true
class TimeSleep < ApplicationRecord
  belongs_to :user
  validates :date, uniqueness: {scope: :user_id}
  validates :start_time, :finish_time, :date, presence: true
  validate :date_is_less_than_or_equal_today?
  validate :start_time_less_than_finish_time?

  def date_is_less_than_or_equal_today?
    return if date.nil?

    errors.add :date, 'must be less than or equal today' if date > Time.current.to_date
  end

  def start_time_less_than_finish_time?
    return if start_time.nil? || finish_time.nil?

    errors.add :finish_time, 'must be greater than start_time' if start_time >= finish_time
  end
end
