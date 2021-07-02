# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSleeps::CreateService do
  subject(:call) { described_class.new(user: user, opts: params).call }
  let(:user) { FactoryBot.create(:user) }
  let(:date) { '2021-07-02' }
  let(:start_time) { '2021-07-02 22:00' }
  let(:finish_time) { '2021-07-03 06:00' }
  let(:params) do
    {
      date: date,
      start_time: start_time,
      finish_time: finish_time
    }
  end
  context 'when params is valid' do
    it { expect { subject }.to change(TimeSleep, :count).by(1) }
  end

  context 'when date has created before' do
    let!(:time_sleep) { FactoryBot.create(:time_sleep, user_id: user.id, date: date) }

    it { expect{ subject }.to raise_error(ActiveRecord::RecordInvalid) }
  end

  context 'when start_time greater than finish_time' do
    let(:finish_time) { '2021-07-02 10:00' }

    it { expect{ subject }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
