require 'rails_helper'

RSpec.describe TimeSleep, type: :model do
  describe 'associations & validations' do
    it { is_expected.to belong_to(:user) }

    it do
      subject.user = FactoryBot.create(:user)
      subject.date = Time.current.to_date
      subject.start_time  = Time.current.to_datetime
      subject.finish_time = (Time.current + 7.hours).to_datetime

      expect(subject).to validate_uniqueness_of(:date).scoped_to(:user_id)
    end

    it 'date less than or equal today' do
      time_sleep = TimeSleep.new
      time_sleep.user = FactoryBot.create(:user)
      time_sleep.date = (Time.current + 1.day).to_date
      time_sleep.start_time  = Time.current.to_datetime
      time_sleep.finish_time = (Time.current + 7.hours).to_datetime
      time_sleep.valid?

      expect(time_sleep.errors.full_messages.first).to eq 'Date must be less than or equal today'
    end

    it 'start_time less than finish_time' do
      time_sleep = TimeSleep.new
      time_sleep.user = FactoryBot.create(:user)
      time_sleep.date = (Time.current - 1.day).to_date
      time_sleep.start_time  = (Time.current + 1.day).to_datetime
      time_sleep.finish_time = Time.current.to_datetime
      time_sleep.valid?

      expect(time_sleep.errors.full_messages.first).to eq 'Finish time must be greater than start_time'
    end

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:finish_time) }
  end
end
