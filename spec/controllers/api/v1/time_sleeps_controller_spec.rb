# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TimeSleepsController, type: :request do
  describe 'Create new time_sleep' do
    subject { post '/api/v1/time_sleeps', headers: headers, params: params }

    let(:user) { FactoryBot.create(:user) }
    let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
    let(:headers) { {'Authorization': "Bearer #{access_token.token}"} }
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
      it_behaves_like 'created_success_request'
    end

    context 'when params is invalid' do
      context 'when date has created before' do
        let!(:time_sleep) { FactoryBot.create(:time_sleep, user_id: user.id, date: date) }
        it_behaves_like 'record_invalid_request'
      end

      context 'when format time is invalid' do
        context 'when start_time is invalid' do
          let(:start_time) { '2020-01-01 99:00' }

          it_behaves_like 'bad_request'
        end

        context 'when finish_time is invalid' do
          let(:finish_time) { '2020-01-01 99:00' }

          it_behaves_like 'bad_request'
        end
      end

      context 'when start_time greater than finish_time' do
        let(:start_time) { '2021-07-02 22:00' }
        let(:finish_time) { '2021-07-02 06:00' }

        it_behaves_like 'record_invalid_request'
      end
    end
  end

  describe 'Get all of time_sleeps' do
    subject { get '/api/v1/time_sleeps', headers: headers }

    let(:user) { FactoryBot.create(:user, name: 'lorem_1') }
    let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id) }
    let(:headers) { {'Authorization': "Bearer #{access_token.token}"} }
    let!(:time_sleep_1_u1) { FactoryBot.create(:time_sleep, user_id: user.id, date: '2021-06-10', created_at: '2021-06-10') }
    let!(:time_sleep_2_u1) { FactoryBot.create(:time_sleep, user_id: user.id, date: '2021-06-15', created_at: '2021-06-15') }
    context 'when return time_sleep for self' do
      it_behaves_like 'success_request'

      it 'response time_sleeps of user' do
        subject
        time_sleeps = JSON.parse(response.body)
        time_sleep_ids = time_sleeps.map { |time_sleep| time_sleep['id'] }

        expect(time_sleep_ids).to eq [time_sleep_1_u1.id, time_sleep_2_u1.id]
      end
    end
  end
end