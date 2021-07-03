# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSleeps::IndexService do
  subject(:call) { described_class.new(user: user, type: type).call }
  let(:user) { FactoryBot.create(:user) }
  let(:type) { 'owner' }
  let(:date_1) { '2021-07-02'}
  let(:date_2) { '2021-06-30'}
  let(:date_3) { '2021-07-01'}
  let!(:time_sleep_1) do
    FactoryBot.create(:time_sleep,
                      user_id: user.id,
                      date: date_1,
                      start_time: "#{date_1} 05:00",
                      finish_time: "#{date_1} 10:00",
                      created_at: date_1)
  end
  let!(:time_sleep_2) do
    FactoryBot.create(:time_sleep, 
                      user_id: user.id, 
                      date: date_2,
                      start_time: "#{date_2} 05:00",
                      finish_time: "#{date_2} 07:00",
                      created_at: date_2)
  end
  let!(:time_sleep_3) do
    FactoryBot.create(:time_sleep,
                      user_id: user.id,
                      date: date_3,
                      start_time: "#{date_3} 05:00",
                      finish_time: "#{date_3} 15:00",
                      created_at: date_3)
  end

  context 'when type is owner' do
    let(:type) { 'owner' }
    it 'sorted by created_at' do
      result = subject
      expected_ids = result.pluck(:id)
      expect([time_sleep_2.id, time_sleep_3.id, time_sleep_1.id]).to eq expected_ids 
    end
  end
end
